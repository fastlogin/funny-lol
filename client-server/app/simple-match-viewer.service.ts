import { Injectable } from '@angular/core';
import { SMVMatch } from './models/smv-match';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class SMVService {
  constructor (private http: Http) {}

  getMatches(matches:string[]) {
  	var matchIds = "";
  	for (let match of matches) {
    	matchIds += match + ",";
	}
	var url = "http://localhost:3001/simple_match_viewer/matches/" + matchIds;
  	return this.http
  		.get(url).map(res => res.json())
  }
}
