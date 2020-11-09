import 'dart:io' show Platform;

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:wenn_flutter_poc/config/inspection_content_mode_config.dart';
import 'package:wenn_flutter_poc/ui/utils/widgets_value_key_constants.dart';

///How to run tests:
///1. You need to create environmental variables
///2. Then run:
///flutter drive --target=test_driver/app_stag.dart --flavor stag

Future<FlutterDriver> setupAndGetDriver() async {
  FlutterDriver driver = await FlutterDriver.connect();
  var connected = false;
  while (!connected) {
    try {
      print('Waiting for first frame');
      await driver.waitUntilFirstFrameRasterized();
      print('First frame appeared');
      connected = true;
    } catch (error) {}
  }
  return driver;
}

void main() {
  // Load environmental variables
  final testUserPhoneNumber =
      Platform.environment['WENN_GARAGE_APP_STAGE_USERNAME'];
  final testUserPassword =
      Platform.environment['WENN_GARAGE_APP_STAGE_PASSWORD'];

  group(
    'UI mobile tests',
    () {
      FlutterDriver _driver;

      // Connect to the Flutter driver before running any tests.
      setUpAll(
        () async {
          print('Connecting driver');
          _driver = await setupAndGetDriver();
          print('Driver connected');
        },
      );

      // Close the connection to the driver after the tests have completed.
      tearDownAll(
        () async {
          print('Closing driver');
          _driver?.close();
          print('Driver closed');
        },
      );

      // Login screen
      test(
        'Login_mobile',
        () async {
          print('Login_mobile');
          final loginAndRegisterScreenLoginButton = find
              .byValueKey(WidgetsValueKeys.loginAndRegisterScreenLoginButton);
          final mobileNumberField =
              find.byValueKey(WidgetsValueKeys.loginScreenPhoneTextFieldKey);
          final passwordField =
              find.byValueKey(WidgetsValueKeys.loginScreenPasswordTextFieldKey);
          final loginScreenContinueButton =
              find.byValueKey(WidgetsValueKeys.loginScreenContinueButton);

          final countryCodeField = find.byType('CountryCodePicker');
          final countryCodeValue = find.text('+48 Polska');

          final mobileNumberFieldText = testUserPhoneNumber;
          final passwordFieldText = testUserPassword;

          await _driver.tap(loginAndRegisterScreenLoginButton);
          await _driver.waitFor(
            find.text(
              await _driver.requestData("login_header_title"),
            ),
          );
          await _driver.tap(countryCodeField);
          await _driver.tap(countryCodeValue);
          await _driver.tap(mobileNumberField);
          await _driver.enterText(mobileNumberFieldText);
          await _driver.waitFor(
            find.text(mobileNumberFieldText),
          );
          await _driver.tap(passwordField);
          await _driver.enterText(passwordFieldText);
          await _driver.waitFor(
            find.text(passwordFieldText),
          );
          await _driver.tap(loginScreenContinueButton);
        },
      );

      //Cases list screen
      test(
        'Cases_list_mobile',
        () async {
          await _driver.runUnsynchronized(
            () async {
              final appraisalListScreenPlusButton = find
                  .byValueKey(WidgetsValueKeys.appraisalListScreenPlusButton);
              await _driver.waitFor(
                find.text(
                  await _driver.requestData("appraisals_list_header_title"),
                ),
              );
              await _driver.tap(appraisalListScreenPlusButton);
            },
          );
        },
      );

      // Info screen
      test(
        'Info_mobile',
        () async {
          if (!InspectionContentModeConfig.isOn) {
            final caseIDField = find.byValueKey(
                WidgetsValueKeys.appraisalInfoScreenCaseIdTextFieldKey);
            final appraisalInfoScreenCreateButton = find
                .byValueKey(WidgetsValueKeys.appraisalInfoScreenCreateButton);

            final caseIdFieldText = DateTime.now().toString();

            await _driver.waitFor(
              find.text(
                await _driver
                    .requestData("appraisal_enter_appraisal_info_header_title"),
              ),
            );
            await _driver.tap(caseIDField);
            await _driver.enterText(caseIdFieldText);
            await _driver.waitFor(
              find.text(caseIdFieldText),
            );
            await _driver.tap(appraisalInfoScreenCreateButton);
          }
          await _driver.waitFor(
            find.text(
              await _driver.requestData(
                  "appraisals_list_start_successful_appraisal_addition"),
            ),
          );
        },
      );

      // Client screen
      test(
        'Client_mobile',
        () async {
          final appraisalOverviewScreenClientButton = find
              .byValueKey(WidgetsValueKeys.appraisalOverviewScreenClientButton);

          final firstName = find
              .byValueKey(WidgetsValueKeys.clientScreenFirstNameTextFieldKey);
          final lastName = find
              .byValueKey(WidgetsValueKeys.clientScreenLastNameTextFieldKey);
          final mobileNumberClient =
              find.byValueKey(WidgetsValueKeys.clientScreenPhoneTextFieldKey);
          final emailAddress =
              find.byValueKey(WidgetsValueKeys.clientScreenEmailTextFieldKey);
          final clientScreenSaveButton =
              find.byValueKey(WidgetsValueKeys.clientScreenSaveButton);

          final countryCodeField = find.byType('CountryCodePicker');
          final countryCodeValue = find.text('+48 Polska');

          final nameFieldText = 'name';
          final lastnameFieldText = 'lastname';
          final mobileNumberFieldText = '012345678';
          final emailFieldText = 'test@test.pl';

          await _driver.tap(appraisalOverviewScreenClientButton);
          await _driver.waitFor(
            find.text(
              await _driver
                  .requestData("appraisal_enter_client_info_header_title"),
            ),
          );
          await _driver.tap(firstName);
          await _driver.enterText(nameFieldText);
          await _driver.waitFor(
            find.text(nameFieldText),
          );
          await _driver.tap(lastName);
          await _driver.enterText(lastnameFieldText);
          await _driver.waitFor(
            find.text(lastnameFieldText),
          );
          await _driver.tap(countryCodeField);
          await _driver.tap(countryCodeValue);
          await _driver.tap(mobileNumberClient);
          await _driver.enterText(mobileNumberFieldText);
          await _driver.waitFor(
            find.text(mobileNumberFieldText),
          );
          await _driver.tap(emailAddress);
          await _driver.enterText(emailFieldText);
          await _driver.waitFor(
            find.text(emailFieldText),
          );
          await _driver.tap(clientScreenSaveButton);
          await _driver.waitFor(
            find.text(
              await _driver.requestData("appraisal_screen_generate_report"),
            ),
          );
        },
      );

      // Car screen
      test(
        'Car_mobile',
        () async {
          final appraisalOverviewScreenCarButton = find
              .byValueKey(WidgetsValueKeys.appraisalOverviewScreenCarButton);

          final registrationNumber =
              find.byValueKey(WidgetsValueKeys.carScreenRegistrationTextField);
          final registrationFetchDetailsIcon = find.byValueKey(
              WidgetsValueKeys.carScreenFetchRegistrationDetailsArrowIcon);
          final currentMilage =
              find.byValueKey(WidgetsValueKeys.carScreenMilageTextField);
          final carScreenSaveButton =
              find.byValueKey(WidgetsValueKeys.carScreenSaveButton);

          final registrationNumberFieldText = "BP99923";
          final carMakeFieldText = 'VOLVO';
          final currentMilageFieldText = '123';

          await _driver.tap(appraisalOverviewScreenCarButton);
          await _driver.waitFor(
            find.text(
              await _driver
                  .requestData("appraisal_enter_vehicle_info_header_title"),
            ),
          );
          await _driver.tap(registrationNumber);
          await _driver.enterText(registrationNumberFieldText);
          await _driver.waitFor(
            find.text(registrationNumberFieldText),
          );
          await _driver.tap(registrationFetchDetailsIcon);
          await _driver.waitFor(
            find.text(carMakeFieldText),
          );
          await _driver.tap(currentMilage);
          await _driver.enterText(currentMilageFieldText);
          await _driver.waitFor(
            find.text(currentMilageFieldText),
          );
          await _driver.tap(carScreenSaveButton);
          await _driver.waitFor(
            find.text(
              await _driver.requestData("appraisal_screen_generate_report"),
            ),
          );
        },
      );
    },
  );
}
