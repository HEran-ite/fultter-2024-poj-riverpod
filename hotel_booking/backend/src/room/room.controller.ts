import { Body, Controller, Delete, Get, Param, Post, Put, Req, UseGuards } from '@nestjs/common';
import { RoomService } from './room.service';
import { Room } from './schemas/room.schema';
import { CreateRoomDto } from './dto/create-room.dto';
import { UpdateRoomDto } from './dto/update-room.dto';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from 'src/auth/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { Role } from 'src/auth/user/schemas/user.schema';

@Controller('room')
export class RoomController {
  constructor(private roomService: RoomService) {}

  @Get()
  async getAllRooms(): Promise<Room[]> {
    return this.roomService.findAll();
  }

  @Post()
  @UseGuards(AuthGuard(), RolesGuard)
  @Roles(Role.Admin)
  async createRoom(
    @Body() room: CreateRoomDto,
    @Req() req
  ): Promise<Room> {
    console.log(req.user);
    return this.roomService.create(room, req.user);
  }

  @Get(':id')
  async getRoom(
    @Param('id') id: string,
  ): Promise<Room> {
    return this.roomService.findById(id);
  }

  @Put(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async updateRoom(
    @Param('id') id: string,
    @Body() room: UpdateRoomDto,
    @Req() req
  ): Promise<Room> {
    return this.roomService.updateById(id, room, req.user);
  }

  @Delete(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async deleteRoom(
    @Param('id') id: string,
    @Req() req
  ): Promise<Room> {
    return this.roomService.deleteById(id, req.user);
  }
}
