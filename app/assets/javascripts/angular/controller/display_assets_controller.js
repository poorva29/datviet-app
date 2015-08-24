var myApp = angular.module('DatvietApp', ['ui.bootstrap', 'ngTable', 'ngRoute', 'ngResource']);

  //Factory
  myApp.factory('DisplayAssets', ['$resource',function($resource){
    return $resource('/display_assets.json', {},{
      query: { method: 'GET', isArray: true },
      create: { method: 'POST' }
    })
  }]);

  //Controller
  myApp.controller("DisplayAssetListCtr", function($scope, $http, $resource, DisplayAssets, $location, $modal, $log) {
    $scope.display_assets = DisplayAssets.query();
      $scope.play_asset = function(selected_asset) {
        $scope.open(selected_asset, '');
      }

      $scope.animationsEnabled = true;

      $scope.open = function (selected_asset, size) {
        var modalInstance = $modal.open({
          animation: $scope.animationsEnabled,
          templateUrl: 'myModalContent.html',
          controller: 'ModalInstanceCtrl',
          size: size,
          backdrop: 'static',
          resolve: {
            items: function () {
              return {
                selected_asset: selected_asset
              };
            }
          }
        });
      };

      $scope.toggleAnimation = function () {
        $scope.animationsEnabled = !$scope.animationsEnabled;
      };
  });

  myApp.controller('ModalInstanceCtrl', function ($scope, $modalInstance, items) {
    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };

    $scope.selected = items.selected_asset;

    $scope.append_data = function() {
      kWidget.embed({
        'targetId': 'myEmbedTarget',
        'wid': '_1988382',
        'uiconf_id' : '30743062',
        'entry_id' : $scope.selected.entry_id,
        'flashvars':{ // flashvars allows you to set runtime uiVar configuration overrides.
          'autoPlay': false
        },
        'params':{ // params allows you to set flash embed params such as wmode, allowFullScreen etc
          'wmode': 'transparent'
        }
      });
    };
  });

  //Routes
  myApp.config([
    '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
      $routeProvider.when('/display_assets',{
        templateUrl: '/templates/display_assets/index.html',
        controller: 'DisplayAssetListCtr'
      });
      $routeProvider.otherwise({
        redirectTo: '/display_assets'
      });
    }
  ]);

