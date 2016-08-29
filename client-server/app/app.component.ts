import { Component } from '@angular/core';
import { RouteConfig, ROUTER_DIRECTIVES, ROUTER_PROVIDERS } from '@angular/router-deprecated';
import { MatchListComponent } from './matchlist.component';
import { MatchListService } from './matchlist.service';

@Component({
  selector: 'my-app',
  templateUrl: 'app/assets/templates/main.html',
  directives: [ROUTER_DIRECTIVES],
  providers: [
    ROUTER_PROVIDERS,
    MatchListService
  ]
})

@RouteConfig([
  {
    path: '/list',
    name: 'MatchList',
    component: MatchListComponent,
    useAsDefault: true
  },
  // This is for us to reroute the default route to the matchlist route.
  { 
  	path: '/**', 
  	redirectTo: 
  	['MatchList'] 
  }
])


export class AppComponent {
	title = 'http://static.comicvine.com/uploads/original/13/139093/3188839-gundam-wing2.jpg';
}
