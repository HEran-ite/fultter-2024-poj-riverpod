import {IsNotEmpty ,IsString,IsNumber} from "class-validator";

export class UpdateFeedbackDto {
    @IsNotEmpty()
    @IsString()
    customerName?: string;

    @IsNotEmpty()
    @IsString()
    message?: string;

    @IsNotEmpty()
    @IsNumber()
    rating?: Number;
  }
  