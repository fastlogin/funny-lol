
import { SMVParticipant } from './smv-participant';

export class SMVMatch {
	id: number;
	duration: number;
	blueParticipants: SMVParticipant[];
	purpleParticipants: SMVParticipant[];
	blueWon: boolean;
}
