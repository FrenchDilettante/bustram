describe('bustram.stops.StopController', function () {
  var StopController,
      $controller,
      $rootScope,
      $httpBackend,
      $timeout;

  beforeEach(angular.mock.module('bustram.stops'));

  beforeEach(inject(function ($injector) {
    $controller = $injector.get('$controller');
    $httpBackend = $injector.get('$httpBackend');
    $rootScope = $injector.get('$rootScope');
    $timeout = $injector.get('$timeout');

    StopController = $controller('StopController', {
      $scope: $rootScope
    });
  }));

  describe('estimatedTime', function () {
    it('should give 1 minute', function () {
      var oneMinuteFromNow = new Date();
      oneMinuteFromNow.setMinutes(oneMinuteFromNow.getMinutes() + 1);

      expect($rootScope.estimatedTime(oneMinuteFromNow)).toBe(1);
    });
  });

  describe('loadSchedules', function () {
    var basicSchedule = {
      departure_time: '2015-02-05T21:10:40.000+00:00',
      route_id: 'A',
      headsign: 'ANGERS ROSERAIE'
    };

    it('load schedules', function () {
      setHttpGetSchedulesExpectations([basicSchedule]);
      $httpBackend.flush();

      expect($rootScope.schedules).toBeDefined();
      expect($rootScope.schedules[0].departure_time instanceof Date).toBe(true);
    });

    it('should reload schedules the next minute', function () {
      setHttpGetSchedulesExpectations([]);
      $httpBackend.flush();

      setHttpGetSchedulesExpectations([]);
      $timeout.flush();
    });

    function setHttpGetSchedulesExpectations(response) {
      $httpBackend.
        expectGET('/api/v1/stops/undefined/schedules').
        respond(response);
    }
  });

  describe('toggleDisplay', function () {
    it('should show departure after remaining and vice-versa', function () {
      $rootScope.toggleDisplay();
      expect($rootScope.showDeparture).toBe(true);
      $rootScope.toggleDisplay();
      expect($rootScope.showDeparture).toBe(false);
    });
  });

});
