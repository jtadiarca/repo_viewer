import 'package:auto_route/annotations.dart';
import 'package:repo_viewer/github/detail/presentation/repo_detail_page.dart';

import '../../../auth/presentation/authorization_page.dart';
import '../../../auth/presentation/sign_in_page.dart';
import '../../../github/repos/searched_repos/presentation/searched_repos_page.dart';
import '../../../github/repos/starred_repos/presentation/starred_repos_page.dart';
import '../../../splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage, path: '/sign-in'),
    MaterialRoute(page: AuthorizationPage, path: '/auth'),
    MaterialRoute(page: StarredReposPage, path: '/starred'),
    MaterialRoute(page: SearchedReposPage, path: '/search'),
    MaterialRoute(page: RepoDetailPage, path: '/detail'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
