// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Order, OrderCreateDto, OrderUpdateDto } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';
import { OrderStatus } from '../../domain/models/OrderStatus';
import { v4 as uuidv4 } from 'uuid';

export class OrderService {
    constructor(private orderRepository: OrderRepository) {}

    async createOrder(orderData: OrderCreateDto): Promise<Order> {
      throw new Error('TODO(reto): createOrder');
    }

    async getOrder(id: string): Promise<Order> {
      throw new Error('TODO(reto): getOrder');
    }

    async updateOrder(id: string, orderData: OrderUpdateDto): Promise<Order> {
      throw new Error('TODO(reto): updateOrder');
    }

    async deleteOrder(id: string): Promise<void> {
      throw new Error('TODO(reto): deleteOrder');
    }
}