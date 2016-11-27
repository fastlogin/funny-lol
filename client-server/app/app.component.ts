import { Component } from '@angular/core';
import { RouteConfig, ROUTER_DIRECTIVES, ROUTER_PROVIDERS } from '@angular/router-deprecated';
import { SimpleMatchViewerComponent } from './simple-match-viewer.component';

@Component({
  selector: 'my-app',
  templateUrl: 'app/assets/templates/main.html',
  directives: [ROUTER_DIRECTIVES],
  providers: [
    ROUTER_PROVIDERS
  ]
})

@RouteConfig([
  {
    path: '/smv',
    name: 'SimpleMatchViewer',
    component: SimpleMatchViewerComponent,
    useAsDefault: false
  }
  // This is for us to reroute the default route to the matchlist route.
  // { 
  // 	path: '/**', 
  // 	redirectTo: 
  // 	['MatchList'] 
  // }
])


export class AppComponent {
	title = "Hello World! There is nothing here yet. Funny-LoL is currently being built :)"
}
