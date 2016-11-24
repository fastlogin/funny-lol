import { Injectable } from '@angular/core';
import { Match } from './models/match';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class MatchListService {
  constructor (private http: Http) {}

  // getTime() {
  // 	return this.http
  // 		.get('http://jsonplaceholder.typicode.com/posts').map(res => res.json())
  // }

  // getMatches() {
  //   return this.http
  //     .get('http://localhost:3001/matches').map(res => res.json())
  // }
}
