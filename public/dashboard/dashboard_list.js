var app = angular.module('DatvietApp', ['ui.bootstrap', 'ngTable']);
  app.controller('dashboardListCtrl', function ($scope, $modal, $log, $http) {
    $scope.assets = [{entry_id: "0_xorqmjg0", type: 0, name: 'DemoImname.jpg'},
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
    $scope.selected = items;

    $scope.append_data = function() {
      // $('.modal-body.ng-scope').append('<script src="https://cdnapisec.kaltura.com/p/1988382/sp/198838200/embedIframeJs/uiconf_id/30743062/partner_id/1988382?autoembed=true&entry_id=0_9fyuc4qh&playerId=kaltura_player_1439986332&cache_st=1439986332&width=400&height=333&flashvars[streamerType]=auto"></script>')
    };
  });
