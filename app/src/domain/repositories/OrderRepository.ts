import { Order, OrderCreateDto, OrderUpdateDto } from '../models/Order';

export interface OrderRepository {
    create(order: OrderCreateDto): Promise<Order>;
    findById(id: string): Promise<Order | null>;
    update(id: string, order: OrderUpdateDto): Promise<Order>;
    delete(id: string): Promise<void>;
}