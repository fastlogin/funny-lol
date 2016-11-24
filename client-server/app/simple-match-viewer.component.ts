import { Component } from '@angular/core';
import { Router } from '@angular/router-deprecated';

@Component({
  selector: 'simple-match-viewer',
  templateUrl: 'app/assets/templates/smv.html',
  providers: []
})

export class SimpleMatchViewerComponent {
  constructor(
    private router: Router,
  ) {}
}
