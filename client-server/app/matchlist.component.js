"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require('@angular/core');
var router_deprecated_1 = require('@angular/router-deprecated');
var matchlist_service_1 = require('./matchlist.service');
var MatchListComponent = (function () {
    function MatchListComponent(router, matchListService) {
        this.router = router;
        this.matchListService = matchListService;
    }
    MatchListComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.matchListService.getMatches().subscribe(function (data) {
            _this.matches = data;
        }, function (error) { return alert(error); }, function () { return console.log('Success.'); });
    };
    MatchListComponent.prototype.parseJSONArray = function (data) {
    };
    MatchListComponent = __decorate([
        core_1.Component({
            selector: 'ng2-matches',
            templateUrl: 'app/assets/templates/matchlist.html',
            providers: [matchlist_service_1.MatchListService]
        }), 
        __metadata('design:paramtypes', [router_deprecated_1.Router, matchlist_service_1.MatchListService])
    ], MatchListComponent);
    return MatchListComponent;
}());
exports.MatchListComponent = MatchListComponent;
//# sourceMappingURL=matchlist.component.js.map