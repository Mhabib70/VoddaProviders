import 'package:vodda_providers/Logic/Controllers/app-controller.dart';

const String baseApiUrl = AppController.baseUrl + '/provider_api/v1';

const String baseImageUrl = AppController.baseUrl + '/api/v1';

const String linksUrl = AppController.baseUrl + '/api/v1/setting/getLinks';

const String findAddressUrl = AppController.baseUrl + '/api/v1/findAddress';

const String callOrderUrl = AppController.baseUrl + '/api/v1/order/call';
const String meetOrderUrl = AppController.baseUrl + '/api/v1/order/meet';
const String callPrivateUrl =
    AppController.baseUrl + '/api/v1/order/callPrivate';

const String settingUrl = baseApiUrl + '/setting/getInfo';
const String provincesUrl = baseApiUrl + '/province/list';
const String infoDocumentUrl = baseApiUrl + '/user/getInfoDocument';
const String storeDocumentUrl = baseApiUrl + '/user/storeDocument';
const String serviceListUrl = baseApiUrl + '/service/list';
const String categoryListUrl = baseApiUrl + '/category/list';

const String getUserInfoUrl = baseApiUrl + '/user/getInfo';
const String loginUrl = baseApiUrl + '/user/login';
const String logoutUrl = baseApiUrl + '/user/logout';
const String getUserUrl = baseApiUrl + '/user/getUser';
const String updateUserUrl = baseApiUrl + '/user/update';
const String verifyUrl = baseApiUrl + '/user/verify';
const String avatarUrl = baseApiUrl + '/user/updateAvatar';

const String suggestOrdersUrl = baseApiUrl + '/order/suggestList';
const String myOrdersUrl = baseApiUrl + '/order/myList';
const String myOrdersWithDateUrl = baseApiUrl + '/order/myListWithDate';
const String cancelOrderUrl = baseApiUrl + '/order/cancelOrderRequest';
const String unSuggestOrdersUrl = baseApiUrl + '/order/unSuggested';
const String acceptOrderUrl = baseApiUrl + '/order/accept';
const String notAcceptOrderUrl = baseApiUrl + '/order/notAccepted';
const String startOrderUrl = baseApiUrl + '/order/start';
const String getOrderUrl = baseApiUrl + '/order/get';
const String getOrderDocuemntsUrl = baseApiUrl + '/order/getDocuments';
const String getCvFilesUrl = baseApiUrl + '/user/getCvFiles';
const String setCvUrl = baseApiUrl + '/user/updateCvText';
const String uploadCvImageUrl = baseApiUrl + '/user/uploadCvImage';
const String uploadCvVideoUrl = baseApiUrl + '/user/uploadCvVideo';
const String deleteCvFileUrl = baseApiUrl + '/user/deleteCvFile';

const String myAccountsUrl = baseApiUrl + '/user/myAccount';
const String addAccountUrl = baseApiUrl + '/user/addAccount';
const String updateAccountUrl = baseApiUrl + '/user/updateAccount';
const String removeAccountUrl = baseApiUrl + '/user/removeAccount';
const String mySettlementUrl = baseApiUrl + '/user/mySettlement';
const String myFinancialUrl = baseApiUrl + '/user/myFinancial';
const String myWalletUrl = baseApiUrl + '/user/myWallet';
const String getWalletCashUrl = baseApiUrl + '/user/storeSettlement';
const String setOnlineUrl = baseApiUrl + '/user/setOnline';

const String getMyServicesUrl = baseApiUrl + '/service/myService';
const String updateServiceUrl = baseApiUrl + '/service/updateService';
const String getServiceQuestionsUrl = baseApiUrl + '/service/myQuestions';
const String storeServiceQuestionsUrl = baseApiUrl + '/service/storeQuestion';
const String deleteServiceQuestionsUrl = baseApiUrl + '/service/deleteQuestion';
const String getOptionsUrl = baseApiUrl + '/service/getOptions';
const String storeOptionUrl = baseApiUrl + '/service/storeOption';
const String deleteOptionUrl = baseApiUrl + '/service/deleteOption';
const String getFreeTimesUrl = baseApiUrl + '/reservation/getFreeTimes';
const String addFreeTimeUrl = baseApiUrl + '/reservation/addProviderFreeTime';
const String updateFreeTimeUrl = baseApiUrl + '/reservation/updateFreeTime';
const String deleteFreeTimeUrl = baseApiUrl + '/reservation/deleteFreeTime';
const String getHolidaysUrl = baseApiUrl + '/reservation/getHolidayTimes';
const String addHolidayUrl = baseApiUrl + '/reservation/addHoliday';
const String updateHolidayUrl = baseApiUrl + '/reservation/updateHoliday';
const String deleteHolidayUrl = baseApiUrl + '/reservation/deleteHolidayTime';
const String getYearsUrl = baseApiUrl + '/reservation/getJsonDate';

const String mapApiKey =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3In0.eyJhdWQiOiIxOTA1NiIsImp0aSI6IjQzYmZhMjc4MzE3ZGNmODFhZDUzZjNmMjQ2MGVhNWFhMzJmMWQ3YzgxNTZkOGM3NmM5OGU4NzE1ZDE4YTRjODM2MTJiOWFkMzAwZmVlZTM3IiwiaWF0IjoxNjYwMjMyNjQzLCJuYmYiOjE2NjAyMzI2NDMsImV4cCI6MTY2MjgyNDY0Mywic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.Y0kU-dMjtNJs2cpscoHjwGRoeDhCA4y1SfMchiGL9Nxlx4g9HdukvMBoCB00hkGY5UU1Qfaw9iOHQAgqbWD5qCvqelDSs4xDnnLlyCicDsuqpof2eej2l6twSTdDVaFtCOQiG_LcjusPFZIQP7QNuXI5um-2sYLMvPMmKcuzG6EO2GfVM9vtlftRtmTZ2nvKh3GgRKjqOb8lFKAIw3jKSe9qKj2tPActUAraCHpFWYqhb9bKyR-ODAbo2e2AscZKCcxB97-vj9my8w8eeVh_BQ3i34ijiTzpvPDrLaeGfruphSlusKLzG-7nJKpxRTTPXOJaTcpJaFlQ2l2JsTHqpQ';
