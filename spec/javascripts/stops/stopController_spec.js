describe('bustram.stops.StopController', function () {
  var StopController,
      $controller,
      $rootScope;

  beforeEach(angular.mock.module('bustram.stops'));

  beforeEach(inject(function ($injector) {
    $controller = $injector.get('$controller');
    $rootScope = $injector.get('$rootScope');

    StopController = $controller('StopController', {
      $scope: $rootScope
    });
  }));

  describe('toggleDisplay', function () {
    it('should show departure after remaining and vice-versa', function () {
      $rootScope.toggleDisplay();
      expect($rootScope.showDeparture).toBe(true);
      $rootScope.toggleDisplay();
      expect($rootScope.showDeparture).toBe(false);
    });
  });

});
