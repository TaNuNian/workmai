const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.matchUsers = functions.region('us-central1').https.onCall(async (data, context) => {
    const { userId, mode, ageRange, gender, interestTags, skillTags, rank, openLowerRank } = data;

    console.log('Input Data:', data);

    if (!userId || !mode) {
        throw new functions.https.HttpsError('invalid-argument', 'Required parameters are missing');
    }

    const fetchUidsFromtags = async(tags, category) => {
        let uids = [];
        for (const tag of tags) {
            const categorySnapshot = await admin.firestore().collection('category').doc('tags').get();
            if (categorySnapshot.exists) {
                const tagData = categorySnapshot.data()[category]?.[tag] || [];
                uids = uids.concat(tagData);
            }
        }
        return [...new Set(uids)];
    };

    const interestUids = await fetchUidsFromtags(interestTags, 'interested');
    const skillUids = await fetchUidsFromtags(skillTags, 'skills');

    const currentUserRef = admin.firestore().collection('users').doc(userId);
    const currentUserDoc = await currentUserRef.get();
    if (!currentUserDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'User not found');
    }
    const currentUserData = currentUserDoc.data().profile;

    const currentUserRankRef = admin.firestore().collection('ranks').doc(userId);
    const currentUserRankDoc = await currentUserRankRef.get();
    if (!currentUserRankDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'User rank not found');
    }
    const currentUserRank = currentUserRankDoc.data().rankName;

    const calculateTagScores = (tags, userTags, mainTags) => {
        console.log("tags",tags);
        console.log("userTags",userTags);
        console.log("mainTags",mainTags);
        if (!userTags) return { mainCount: 0, subCount: 0 };

        const mainCount = tags.filter(tag => mainTags.includes(tag) && userTags.includes(tag)).length;
        const subCount = tags.filter(tag => !mainTags.includes(tag) && userTags.includes(tag)).length;
        return { mainCount, subCount };
    };

    const fetchUserDataAndCalculateScores = async (uids, userTags, type, mainTags) => {
        let scores = {
            main: 0,
            sub: 0
        };
        for (const uid of uids) {
            if (uid === userId) continue;

            const userRef = admin.firestore().collection('users').doc(uid);
            const userDoc = await userRef.get();
            if (!userDoc.exists) continue;

            const targetData = userDoc.data().profile;
            if (!targetData || !targetData[type]) continue;

            if (ageRange && (targetData.age < ageRange[0] || targetData.age > ageRange[1])) continue;

            const { mainCount, subCount } = calculateTagScores(userTags, targetData[type], mainTags);
            scores.main += mainCount;
            scores.sub += subCount;
        }
        return scores;
    };

    const mainSkills = ['ศิลปะและการออกแบบ', 'อาหาร', 'กีฬาและสุขภาพ', 'สังคมและวัฒนธรรม', 'การเลี้ยงสัตว์', 'เทคโนโลยี', 'การแพทย์', 'สื่อบันเทิง', 'คณิตศาสตร์', 'วิทยาศาสตร'];
    const mainInterests = ['แฟชั่นและไลฟ์สไตล์', 'ประสบการณ์และการเรียนรู้', 'ศิลปะและการออกแบบ', 'อาหาร', 'กีฬาและสุขภาพ', 'การท่องเที่ยวและสถานที่', 'สังคมและวัฒนธรรม', 'สัตว์', 'เทคโนโลยี', 'การแพทย์', 'สื่อบันเทิง', 'การพัฒนาตนเอง', 'สิ่งแวดล้อมและธรรมชาติ', 'ปรัชญาและทฤษฎี', 'คณิตศาสตร์', 'วิทยาศาสตร์', 'จิตวิทยา'];

    const interestScores = await fetchUserDataAndCalculateScores(interestUids, interestTags, 'interests', mainInterests);
    const skillScores = await fetchUserDataAndCalculateScores(skillUids, skillTags, 'skills', mainSkills);

    const calculateMBTIScore = (userMBTI, targetMBTI) => {
        if (!userMBTI || !targetMBTI) return 0;
        let matchCount = 0;
        for (let i = 0; i < 4; i++) {
            if (userMBTI[i] === targetMBTI[i]) {
                matchCount++;
            }
        }
        return matchCount < 3 ? matchCount : 4;
    };

    const calculateAgeScore = (userAge, targetAge) => {
        if (!userAge || !targetAge) return 4;
        const ageDifference = Math.abs(userAge - targetAge);
        if (ageDifference === 0) return 1;
        if (ageDifference <= 2) return 2;
        return 4;
    };

    const calculateActiveTimeScore = (userActiveTime, targetActiveTime) => {
        if (!userActiveTime || !targetActiveTime) return 0;
        let matchCount = 0;
        userActiveTime.forEach(time => {
            if (targetActiveTime.includes(time)) {
                matchCount++;
            }
        });
        return matchCount;
    };

    const calculateGenderScore = (userGender, targetGender) => {
        if (!userGender || !targetGender) return 0;
        return userGender === targetGender ? 1 : 0;
    };

    const calculateRankScore = (userRank, targetRank) => {
        const ranks = ['unranked', 'beginner', 'intermediate', 'expert'];
        const userRankIndex = ranks.indexOf(userRank);
        const targetRankIndex = ranks.indexOf(targetRank);
        if (openLowerRank) {
            return targetRankIndex <= userRankIndex ? 1 : 0;
        } else {
            return Math.abs(targetRankIndex - userRankIndex) <= 1 ? 1 : 0;
        }
    };

    const calculateTotalScore = async (uids) => {
        let matches = [];
        for (const uid of uids) {
            if (uid === userId) continue;

            const userRef = admin.firestore().collection('users').doc(uid);
            const userDoc = await userRef.get();
            if (!userDoc.exists) continue;

            const targetData = userDoc.data().profile;
            if (!targetData) continue;

            const targetRankRef = admin.firestore().collection('ranks').doc(uid);
            const targetRankDoc = await targetRankRef.get();
            if (!targetRankDoc.exists) continue;

            const targetRank = targetRankDoc.data().rankName;

            const mbtiScore = calculateMBTIScore(currentUserData.mbti, targetData.mbti);
            const ageScore = calculateAgeScore(currentUserData.age, targetData.age);
            const activeTimeScore = calculateActiveTimeScore(currentUserData.activeTime, targetData.activeTime);
            const genderScore = calculateGenderScore(currentUserData.gender, targetData.gender);
            const rankScore = calculateRankScore(currentUserRank, targetRank);

            const tagScores = {
                mainSkill: calculateTagScores(skillTags, targetData.skilled_tags, mainSkills),
                subSkill: calculateTagScores(skillTags, targetData.skilled_tags, mainSkills),
                mainInterest: calculateTagScores(interestTags, targetData.interested_tags, mainInterests),
                subInterest: calculateTagScores(interestTags, targetData.interested_tags, mainInterests)
            };

            // New approach to avoid NaN
            const mbtiAgeActiveGenderRankScore = mbtiScore + (2 / ageScore) + activeTimeScore + genderScore + rankScore;

            let totalScore;
            let tagScore = 0;
            let scaledTagScore = 0;
            let weightedMbtiAgeActiveGenderRankScore = 0;

            if (mode === 'friends') {
                tagScore = (1 * tagScores.mainSkill.mainCount + 1 * tagScores.subSkill.subCount) +
                                 (2 * tagScores.mainInterest.mainCount + 3 * tagScores.subInterest.subCount);
                scaledTagScore = tagScore / 6;
                weightedMbtiAgeActiveGenderRankScore = (3 / 2 * (mbtiAgeActiveGenderRankScore / 13));
                totalScore = scaledTagScore * weightedMbtiAgeActiveGenderRankScore * 100;
            } else {
                tagScore = (2 * tagScores.mainSkill.mainCount + 3 * tagScores.subSkill.subCount) +
                                  (1 * tagScores.mainInterest.mainCount + 2 * tagScores.subInterest.subCount);
                scaledTagScore = tagScore / 5;
                weightedMbtiAgeActiveGenderRankScore = (3 / 2 * (mbtiAgeActiveGenderRankScore / 13));
                totalScore = scaledTagScore * weightedMbtiAgeActiveGenderRankScore * 100;
            }

            if (isNaN(totalScore)) {
//                console.log("Error calculating total score for userId:", uid);
//                console.log("Each Tags Score",tagScores);
//                console.log("MBTI score:", mbtiScore);
//                console.log("Age score:", ageScore);
//                console.log("Active time score:", activeTimeScore);
//                console.log("Gender score:", genderScore);
//                console.log("Rank score:", rankScore);
//                console.log("mbtiAgeActiveGenderRankScore:", mbtiAgeActiveGenderRankScore);
//                console.log("mode:", mode);
//                console.log("tagScore:", tagScore);
//                console.log("scaledTagScore:", scaledTagScore);
//                console.log("weightedMbtiAgeActiveGenderRankScore:", weightedMbtiAgeActiveGenderRankScore);
                totalScore = 0;
            }

            matches.push({ userId: uid, score: totalScore });
        }
        return matches;
    };

    const allUids = [...new Set([...interestUids, ...skillUids])];
    const matches = await calculateTotalScore(allUids);

    const sortedMatches = matches.sort((a, b) => b.score - a.score);

    console.log('Matches found:', sortedMatches);
    return { matchedUsers: sortedMatches };
});
