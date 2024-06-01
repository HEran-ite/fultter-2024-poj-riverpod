import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Feedback, FeedbackDocument } from './schema/feedback.schema';
import { CreateFeedbackDto } from './dto/create-feedback.dto';
import { UpdateFeedbackDto } from './dto/update-feedback.dto';
import { User } from 'src/auth/user/schemas/user.schema';

@Injectable()
export class FeedbackService {
  constructor(@InjectModel(Feedback.name) private feedbackModel: Model<FeedbackDocument>) {}

  async create(createFeedbackDto: CreateFeedbackDto, user: User): Promise<Feedback> {
    const feedbackData = Object.assign(createFeedbackDto, { user: user._id });
    const createdFeedback = new this.feedbackModel(feedbackData);
    return createdFeedback.save();
  }

  async findAll(): Promise<Feedback[]> {
    return this.feedbackModel.find().exec();
  }

  async update(id: string, updateFeedbackDto: UpdateFeedbackDto, user: User): Promise<Feedback> {
    const filter = { _id: id, user: user._id };
    console.log('Update Filter:', filter);
    console.log('Update DTO:', updateFeedbackDto);

    const updatedFeedback = await this.feedbackModel.findOneAndUpdate(filter, updateFeedbackDto, { new: true }).exec();
    console.log('Updated Feedback:', updatedFeedback);

    if (!updatedFeedback) {
      throw new Error('Feedback not found or not authorized to update');
    }

    return updatedFeedback;
  }

  async delete(id: string, user: User): Promise<any> {
    const filter = { _id: id, user: user._id };
    console.log('Delete Filter:', filter);

    const deletedFeedback = await this.feedbackModel.findOneAndDelete(filter).exec();
    console.log('Deleted Feedback:', deletedFeedback);

    if (!deletedFeedback) {
      throw new Error('Feedback not found or not authorized to delete');
    }

    return deletedFeedback;
  }
}