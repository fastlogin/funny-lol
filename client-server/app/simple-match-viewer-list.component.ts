import { Component, Input, OnInit, OnChanges, SimpleChange, ChangeDetectionStrategy } from '@angular/core';
import { Router } from '@angular/router-deprecated';
import { SMVMatch } from './models/smv-match';
import { SMVParticipant } from './models/smv-participant';
import { SMVService } from './simple-match-viewer.service'

@Component({
  selector: 'simple-match-viewer-list',
  templateUrl: 'app/assets/templates/smvlist.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [SMVService]
})

export class SimpleMatchViewerListComponent {

  @Input() matchIds: string[];
  matches: SMVMatch[];
  
  constructor(
    private smvService: SMVService
    ) {}

  private calculateMinSec(match_duration:number) {
    var minutes = "0" + Math.floor(match_duration / 60);
    var seconds = "0" + (match_duration - minutes * 60);
    return minutes.substr(-2) + ":" + seconds.substr(-2);
  }

  private calculateTotalKills(team:SMVParticipant[]) {
    var totalKills = 0;
    for (let participant of team) {
      totalKills += participant.killCount;
    }
    return totalKills;
  }

  private calculateTotalGold(team:SMVParticipant[]) {
    var totalGold = 0;
    for (let participant of team) {
      totalGold += participant.goldEarned;
    }
    return totalGold;
  }

  private prettyPrintGold(gold:number) {
    var goldInThousands = gold / 1000;
    return (Math.round(goldInThousands * 10) / 10) + "k";
  }

  private calculateKDA(kills:number, deaths:number, assists:number) {
    return kills.toString() + "/" + deaths.toString() + "/" + assists.toString();
  }

  ngOnChanges() {
    if (this.matchIds.length) {
      this.smvService.getMatches(this.matchIds).subscribe(
        (data: SMVMatch[]) => {
          this.matches = data;
        },
        error => alert(error),
        () => console.log('Success. ' + this.matchIds.length + ' matches successfully fetched.')
        );
    }
  }
}
