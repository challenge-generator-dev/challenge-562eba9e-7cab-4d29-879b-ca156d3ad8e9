import { Request, Response } from 'express';
import { OrderService } from '../../application/services/OrderService';
import { OrderCreateDto, OrderUpdateDto } from '../../domain/models/Order';
import { validationResult } from 'express-validator';

export class OrderController {
    constructor(private orderService: OrderService) {}

    async createOrder(req: Request, res: Response): Promise<void> {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            res.status(400).json({ errors: errors.array() });
            return;
        }

        try {
            const orderData: OrderCreateDto = req.body;
            const order = await this.orderService.createOrder(orderData);
            res.status(201).json(order);
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
        }
    }

    async getOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            const order = await this.orderService.getOrder(id);
            res.status(200).json(order);
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }

    async updateOrder(req: Request, res: Response): Promise<void> {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            res.status(400).json({ errors: errors.array() });
            return;
        }

        try {
            const { id } = req.params;
            const orderData: OrderUpdateDto = req.body;
            const order = await this.orderService.updateOrder(id, orderData);
            res.status(200).json(order);
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else if (error instanceof Error && error.message === 'Invalid order status') {
                res.status(400).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }

    async deleteOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            await this.orderService.deleteOrder(id);
            res.status(204).send();
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }
}