import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const matchUsers = functions.region('us-central1').https.onCall(async (data, context) => {
    const { userId, mode, ageRange, gender, interestTags, skillTags, rank, openLowerRank } = data;

    if (!userId || !mode) {
        throw new functions.https.HttpsError('invalid-argument', 'Required parameters are missing');
    }

    const userRef = admin.firestore().collection('users').doc(userId);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'User not found');
    }

    const userData = userDoc.data();

    const usersSnapshot = await admin.firestore().collection('users').get();
    let matches: any[] = [];

    usersSnapshot.forEach(targetDoc => {
        if (targetDoc.id === userId) return;
        const targetData = targetDoc.data();

        // Filtering logic
        if (ageRange && targetData.age !== undefined && (targetData.age < ageRange[0] || targetData.age > ageRange[1])) return;
        if (gender && targetData.gender !== undefined && targetData.gender !== gender) return;
        if (interestTags && !interestTags.every(tag => targetData.interests && targetData.interests.includes(tag))) return;
        if (skillTags && !skillTags.every(tag => targetData.skills && targetData.skills.includes(tag))) return;

        // Rank filtering logic
        const rankDifference = getRankDifference(userData.rank, targetData.rank);
        if (!openLowerRank && Math.abs(rankDifference) > 1) return;
        if (openLowerRank && rankDifference > 1) return;

        const score = calculateScore(userData, targetData, mode);
        matches.push({ userId: targetDoc.id, score, data: targetData });
    });

    matches.sort((a, b) => b.score - a.score);
    return { matchedUsers: matches };
});

function getRankDifference(userRank: string, targetRank: string) {
    const ranks = ['unranked', 'beginner', 'intermediate', 'expert'];
    return ranks.indexOf(targetRank) - ranks.indexOf(userRank);
}

function calculateScore(user: any, target: any, mode: string) {
    const mainSkills = ['ศิลปะและการออกแบบ', 'อาหาร', 'กีฬาและสุขภาพ', 'สังคมและวัฒนธรรม', 'การเลี้ยงสัตว์', 'เทคโนโลยี', 'การแพทย์', 'สื่อบันเทิง', 'คณิตศาสตร์', 'วิทยาศาสตร'];
    const mainInterests = ['แฟชั่นและไลฟ์สไตล์', 'ประสบการณ์และการเรียนรู้', 'ศิลปะและการออกแบบ', 'อาหาร', 'กีฬาและสุขภาพ', 'การท่องเที่ยวและสถานที่', 'สังคมและวัฒนธรรม', 'สัตว์', 'เทคโนโลยี', 'การแพทย์', 'สื่อบันเทิง', 'การพัฒนาตนเอง', 'สิ่งแวดล้อมและธรรมชาติ', 'ปรัชญาและทฤษฎี', 'คณิตศาสตร์', 'วิทยาศาสตร์', 'จิตวิทยา'];

    const mainSk = calculateTagMatch(user.skills, target.skills, mainSkills);
    const subSk = calculateTagMatch(user.skills, target.skills, null, mainSkills);
    const mainIn = calculateTagMatch(user.interests, target.interests, mainInterests);
    const subIn = calculateTagMatch(user.interests, target.interests, null, mainInterests);

    const mbti = calculateMBTIMatch(user.mbti, target.mbti);
    const age = Math.abs(user.age - target.age) || 1;
    const aTime = calculateActiveTimeMatch(user.activeTime, target.activeTime);

    if (mode === 'friends') {
        return ((mainSk + subSk + mainIn + subIn) / 6) * ((mbti + (2 / age) + aTime) / 13) * 100;
    } else {
        return ((2 * mainSk + 3 * subSk + mainIn + 2 * subIn) / 5) * ((mbti + (2 / age) + aTime) / 13) * 100;
    }
}

function calculateTagMatch(userTags: string[], targetTags: string[], mainTags: string[], excludeTags: string[] = []) {
    if (!userTags || !targetTags) return 0;
    let matchCount = 0;
    userTags.forEach(tag => {
        if ((mainTags ? mainTags.includes(tag) : !excludeTags.includes(tag)) && targetTags.includes(tag)) {
            matchCount++;
        }
    });
    return matchCount;
}

function calculateMBTIMatch(userMBTI: string, targetMBTI: string) {
    if (!userMBTI || !targetMBTI) return 0;
    let matchCount = 0;
    for (let i = 0; i < 4; i++) {
        if (userMBTI[i] === targetMBTI[i]) {
            matchCount++;
        }
    }
    return matchCount < 3 ? matchCount : 4;
}

function calculateActiveTimeMatch(userActiveTime: string[], targetActiveTime: string[]) {
    if (!userActiveTime || !targetActiveTime) return 0;
    let matchCount = 0;
    userActiveTime.forEach(time => {
        if (targetActiveTime.includes(time)) {
            matchCount++;
        }
    });
    return matchCount;
}
