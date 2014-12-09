describe('bustram.stops.remainingFilter', function () {

  var remaining;

  beforeEach(angular.mock.module('bustram.stops'));

  beforeEach(inject(function ($injector) {
    remaining = $injector.get('remainingFilter');
  }));

  it('should display minutes', function () {
    expect(remaining(1)).toEqual('1m');
    expect(remaining(12)).toEqual('12m');
    expect(remaining(59)).toEqual('59m');
  });

  it('should display hours', function () {
    expect(remaining(70)).toEqual('1h');
    expect(remaining(90)).toEqual('1h');
    expect(remaining(130)).toEqual('2h');
  });

  it('should display "now"', function () {
    expect(remaining(0)).toEqual('maintenant');
  });

});
