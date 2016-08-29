import { Component } from '@angular/core';
import { Router } from '@angular/router-deprecated';
import { Match } from './models/match';
import { MatchListService } from './matchlist.service'

@Component({
  selector: 'ng2-matches',
  templateUrl: 'app/assets/templates/matchlist.html',
  providers: [MatchListService]
})

export class MatchListComponent {
  matches: Match[];
  constructor(
    private router: Router,
    private matchListService: MatchListService
  ) {}

  ngOnInit() {
    this.matchListService.getMatches().subscribe(
        (data: Match[]) => {
          this.matches = data;
        },
        error => alert(error),
        () => console.log('Success.')
      );
  }

  parseJSONArray(data:string) {

  }

}

