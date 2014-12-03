var module = angular.module('bustram.static', []);

module.controller('SearchController',
  ['$scope', '$http',
  function ($scope, $http) {

    function loadStops(q) {
      delete $scope.stops;

      if (!q || q.length <= 2) {
        return;
      }

      $http.
        get('/api/v1/stops?q=' + q).
        then(function (response) {
          $scope.stops = response.data;
        });
    }

    $scope.$watch('q', loadStops);
  }]);
