import 'package:get/get.dart';

import 'package:lustore/app/modules/config/change_password/config_change_password_binding.dart';
import 'package:lustore/app/modules/config/change_password/config_change_password_view.dart';
import 'package:lustore/app/modules/config/config_binding.dart';
import 'package:lustore/app/modules/config/config_view.dart';
import 'package:lustore/app/modules/config/list_admin/config_list_admin_binding.dart';
import 'package:lustore/app/modules/config/list_admin/config_list_admin_view.dart';
import 'package:lustore/app/modules/config/list_admin/create/config_list_admin_create_binding.dart';
import 'package:lustore/app/modules/config/list_admin/create/config_list_admin_create_view.dart';
import 'package:lustore/app/modules/config/user/config_user_binding.dart';
import 'package:lustore/app/modules/config/user/config_user_view.dart';
import 'package:lustore/app/modules/home/home_binding.dart';
import 'package:lustore/app/modules/home/home_view.dart';
import 'package:lustore/app/modules/home/lister_sales_products/home_lister_sales_products_binding.dart';
import 'package:lustore/app/modules/home/lister_sales_products/home_lister_sales_products_view.dart';
import 'package:lustore/app/modules/login/forget/login_forget_binding.dart';
import 'package:lustore/app/modules/login/forget/login_forget_view.dart';
import 'package:lustore/app/modules/login/login_binding.dart';
import 'package:lustore/app/modules/login/login_view.dart';
import 'package:lustore/app/modules/register/category/register_category_binding.dart';
import 'package:lustore/app/modules/register/category/register_category_view.dart';
import 'package:lustore/app/modules/register/product/create_and_update/register_product_create_and_update_binding.dart';
import 'package:lustore/app/modules/register/product/create_and_update/register_product_create_and_update_view.dart';
import 'package:lustore/app/modules/register/product/register_product_binding.dart';
import 'package:lustore/app/modules/register/product/register_product_view.dart';
import 'package:lustore/app/modules/register/register_binding.dart';
import 'package:lustore/app/modules/register/register_view.dart';
import 'package:lustore/app/modules/reports/reports_binding.dart';
import 'package:lustore/app/modules/reports/reports_view.dart';
import 'package:lustore/app/modules/splash/splash_binding.dart';
import 'package:lustore/app/modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME_LISTER_SALES_PRODUCTS,
          page: () => const HomeListerSalesProductsView(),
          binding: HomeListerSalesProductsBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: _Paths.LOGIN_FORGET,
          page: () => LoginForgetView(),
          binding: LoginForgetBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => const ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      children: [
        GetPage(
          name: _Paths.REGISTER_CATEGORY,
          page: () => const RegisterCategoryView(),
          binding: RegisterCategoryBinding(),
        ),
        GetPage(
            name: _Paths.REGISTER_PRODUCT,
            page: () => const RegisterProductView(),
            binding: RegisterProductBinding(),
            children: [
              GetPage(
                name: _Paths.REGISTER_PRODUCT_CREATE_AND_UPDATE,
                page: () => RegisterProductCreateAndUpdateView(),
                binding: RegisterProductCreateAndUpdateBinding(),
              ),
            ]),
      ],
    ),
    GetPage(
        name: _Paths.CONFIG,
        page: () => const ConfigView(),
        binding: ConfigBinding(),
        children: [
          GetPage(
            name: _Paths.CONFIG_USER,
            page: () => ConfigUserView(),
            binding: ConfigUserBinding(),
          ),
          GetPage(
            name: _Paths.CONFIG_CHANGE_PASSWORD,
            page: () => ConfigChangePasswordView(),
            binding: ConfigChangePasswordBinding(),
          ),
          GetPage(
            name: _Paths.CONFIG_LIST_ADMIN,
            page: () => ConfigListAdminView(),
            binding: ConfigListAdminBinding(),
            children: [
              GetPage(
                name: _Paths.CONFIG_LIST_ADMIN_CREATE,
                page: () => ConfigListAdminCreateView(),
                binding: ConfigListAdminCreateBinding(),
              ),
            ]
          ),
        ]),

  ];
}
