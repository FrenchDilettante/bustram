module = angular.module('bustram.stops', []);

module.controller('StopController',
  ['$scope', '$http',
  function ($scope, $http) {

    function getCurrentStopId() {
      return location.pathname.split('/')[2];
    }

    function loadSchedules() {
      $http.
        get('/api/v1/stops/' + getCurrentStopId() + '/schedules').
        then(function (response) {
          $scope.schedules = _.map(response.data, function (schedule) {
            schedule.departure_time = new Date(schedule.departure_time);
            return schedule;
          });
        });
    }

    $scope.estimatedTime = function (time) {
      return Math.trunc((time - new Date()) / 60000);
    };

    $scope.toggleDisplay = function () {
      $scope.showDeparture = !$scope.showDeparture;
    }

    $scope.showDeparture = false;

    loadSchedules();
  }]);

module.filter('remaining',
  function () {
    return function (remaining) {
      var hours = Math.trunc(remaining / 60),
          mins = remaining % 60;
      return (hours > 0 ? hours + 'h' : 0) + mins + 'm';
    }
  });
