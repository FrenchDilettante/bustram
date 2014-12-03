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

    loadSchedules();
  }]);
