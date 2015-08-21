var app = angular.module('DatvietApp', ['ui.bootstrap', 'ngTable']);
  app.controller('dashboardListCtrl', function ($scope, $modal, $log, $http) {
    $scope.assets = [{entry_id: "0_knzzel05", type: 2, name: 'Kaltura Education Video Solutions'},
                    {entry_id: "0_sy3r5yud", type: 2, name: 'DemoVideo.flv'},
                    {entry_id: "0_9fyuc4qh", type: 2, name: 'Microsoft VOD'},
                    {entry_id: "0_6nc0394y", type: 2, name: 'Kaltura Video Solutions for Media Companies'},
                    {entry_id: "0_ybp0oldp", type: 1, name: 'Kaltura Platform Overview - Audio'}];

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

  app.controller('ModalInstanceCtrl', function ($scope, $modalInstance, items) {
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

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };
  });
