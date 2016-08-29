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
var matchlist_component_1 = require('./matchlist.component');
var matchlist_service_1 = require('./matchlist.service');
var AppComponent = (function () {
    function AppComponent() {
        this.title = 'http://static.comicvine.com/uploads/original/13/139093/3188839-gundam-wing2.jpg';
    }
    AppComponent = __decorate([
        core_1.Component({
            selector: 'my-app',
            templateUrl: 'app/assets/templates/main.html',
            directives: [router_deprecated_1.ROUTER_DIRECTIVES],
            providers: [
                router_deprecated_1.ROUTER_PROVIDERS,
                matchlist_service_1.MatchListService
            ]
        }),
        router_deprecated_1.RouteConfig([
            {
                path: '/list',
                name: 'MatchList',
                component: matchlist_component_1.MatchListComponent,
                useAsDefault: true
            },
            // This is for us to reroute the default route to the matchlist route.
            {
                path: '/**',
                redirectTo: ['MatchList']
            }
        ]), 
        __metadata('design:paramtypes', [])
    ], AppComponent);
    return AppComponent;
}());
exports.AppComponent = AppComponent;
//# sourceMappingURL=app.component.js.map