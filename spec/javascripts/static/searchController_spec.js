describe('bustram.static.SearchController', function () {
  var SearchController,
      $controller,
      $rootScope,
      $httpBackend;

  beforeEach(angular.mock.module('bustram.static'));

  beforeEach(inject(function ($injector) {
    $controller = $injector.get('$controller');
    $httpBackend = $injector.get('$httpBackend');
    $rootScope = $injector.get('$rootScope');
    $timeout = $injector.get('$timeout');

    SearchController = $controller('SearchController', {
      $scope: $rootScope
    });
  }));

  describe('loadStops', function () {

    it('should load a list of stops', function () {
      setHttpGetStopsExpectations('test');
      $rootScope.q = 'test';
      $httpBackend.flush();
    });

    it('should not load if the query is too short', function () {
      $rootScope.q = 't';
      $rootScope.$digest();
    });

    function setHttpGetStopsExpectations(query) {
      $httpBackend.
        expectGET('/api/v1/stops?q=' + query).
        respond(200);
    }
  });

});
