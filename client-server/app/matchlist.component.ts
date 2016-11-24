import { Component } from '@angular/core';
import { Router } from '@angular/router-deprecated';
import { Match } from './models/match';
import { MatchListService } from './matchlist.service'

@Component({
  selector: 'matches',
  templateUrl: 'app/assets/templates/matchlist.html',
  providers: [MatchListService]
})

export class MatchListComponent {
  matches: Match[];
  some_field: string;
  constructor(
    private router: Router,
    private matchListService: MatchListService
  ) {}

  ngOnInit() {
    // this.matchListService.getMatches().subscribe(
    //     (data: Match[]) => {
    //       this.matches = data;
    //     },
    //     error => alert(error),
    //     () => console.log('Success.')
    //   );
    this.matches = [];
    this.some_field = "Hello World."
  }

  parseJSONArray(data:string) {

  }
}
