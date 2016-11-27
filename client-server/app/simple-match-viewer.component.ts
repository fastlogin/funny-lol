import { Component, ViewChild } from '@angular/core';
import { Router } from '@angular/router-deprecated';
import { SimpleMatchViewerListComponent } from './simple-match-viewer-list.component'

@Component({
  selector: 'simple-match-viewer',
  templateUrl: 'app/assets/templates/smv.html',
  directives: [SimpleMatchViewerListComponent]
})

export class SimpleMatchViewerComponent {

  matchIds: string[];

  constructor(private router: Router){
    this.matchIds = [];
  }

  updateMatches() {
    let matchInput = document.getElementById('js-smv-match-input');
    var splitMatchIds = matchInput.value.split(/\n/);
    this.matchIds = splitMatchIds;
  }
}
