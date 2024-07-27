import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/bottom_nav/bottom_nav.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_work_chat_setting.dart';
import 'package:workmai/src/main_pages/chat_page/chatlist_page.dart';
import 'package:workmai/src/main_pages/friendlist_page/add_friend_page.dart';
import 'package:workmai/src/main_pages/friendlist_page/friendlist_page.dart';
import 'package:workmai/src/main_pages/home_page/home_page.dart';
import 'package:workmai/src/main_pages/home_page/home_page_wg/home_topmatch_tile.dart';
import 'package:workmai/src/main_pages/matching_page/matching_list.dart';
import 'package:workmai/src/main_pages/matching_page/matching_page.dart';
import 'package:workmai/src/main_pages/matching_page/matching_recc_page.dart';
import 'package:workmai/src/main_pages/matching_page/matching_result.dart';
import 'package:workmai/src/main_pages/matching_page/matching_select_page.dart';
import 'package:workmai/src/main_pages/matching_page/test_let_match.dart';
import 'package:workmai/src/main_pages/news_page/news_page.dart';
import 'package:workmai/src/main_pages/profile_pages/edit_my_profile.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile.dart';
import 'package:workmai/src/main_pages/rank_page/rank_page.dart';
import 'package:workmai/src/main_pages/review_page/review_page.dart';
import 'package:workmai/src/main_pages/settings_page/settings_page.dart';
import 'package:workmai/src/main_pages/temp/web_board_list_page.dart';
import 'package:workmai/src/main_pages/webboard_page/web_board_create_page.dart';
import 'package:workmai/src/main_pages/webboard_page/web_board_list_page.dart';
import 'package:workmai/src/main_pages/webboard_page/web_board_page.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_intro/create_acc_intro.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_inter/create_acc_inter.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_ness.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_intro/create_acc_unness_intro.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_skill/create_acc_skill.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/create_acc_unness.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_2.dart';
import 'package:workmai/src/pre_pages/register_page/register_page.dart';

Map<String, WidgetBuilder> routes = {

  // // Start
  // '/': (context) => const LoginPage2(),

  // // Bottom Navigator
  '/bottomnav': (context) => const BottomNav(),

  // // Pre-page

  // Login
  '/login2': (context) => const LoginPage2(),

  // Register
  '/register': (context) => const RegisterPage(),

  // Create Account
  '/create-account' : (context) => const CreateAccIntro(),
  '/create-acc-ness' : (context) => const CreateAccNess(),
  '/create-acc-skill' : (context) => const CreateAccSkill(),
  '/create-acc-inter' : (context) => const CreateAccInter(),

  // Unnecessary
  '/create-acc-unness-intro' : (context) => const CreateAccUnnessIntro(),
  '/create-acc-unness' : (context) => const CreateAccUnness(),


  // // Main Page

  // Home
  '/home' : (context) => const HomePage(),

  // Profile
  '/profile-self' : (context) => const MyProfile(), // TODO
  '/profile-edit' : (context) => const EditMyProfile(),

  // Matching
  '/match-page' : (context) => const MatchingPage(),
  '/match-recc-page' : (context) => MatchingReccPage(),
  '/match-select-page' : (context) => const MatchingSelectPage(),
  // '/match-result-page' : (context) => MatchingResultPage(),

  // Web board
  '/webboard-list-page' : (context) => const WebBoardListPage(),
  '/webboard-create-page' : (context) => const WebBoardCreatePage(),
  // '/webboard-page' : (context) => const WebBoardPage(),

  // Chat
  // '/chat-list' : (context) => const ChatListPage(),
  // '/chat-friend' : (context) => const FriendChatPage(), // TODO

  // Review
  '/review-page' : (context) => const ReviewPage(),

  // News
  '/news-page' : (context) => const NewsPage(),
  // '/news-create-page' : (context) => const NewsCreatePage(),

  // Friends
  '/friend-list' : (context) => const FriendlistPage(),
  '/friend-add' : (context) => const AddFriendPage(),
  // '/friend-chat' : (context) => const FriendChatPage(),

  // Rank
  '/rank-page' : (context) => const RankPage(),

  //
  '/settings-page' : (context) => const SettingsPage(),


  // // For Testing & AI-Generated code

  // Chat
  // '/aigen-chat' : (context) => const BbgenFriendChatPage(), // TODO
  // '/aigen-chat-setting' : (context) => BbgenChatSetting(), // TODO ( IN USE )
  '/aigen-chat-setting-work' : (context) => BbgenWorkChatSetting(), // TODO ( IN USE )
  // '/chat-dm' : (context) => const ChatListPage(),
  // '/chat-group' : (context) => const ChatListPage(),
  // '/chat-work' : (context) => const ChatListPage(),

  // Widget Test
  // '/home-topmatch-tile' : (context) => const TestCardTopMatch(),
};