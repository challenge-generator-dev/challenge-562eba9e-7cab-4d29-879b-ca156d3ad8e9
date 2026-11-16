import express, { Application, Request, Response, NextFunction } from 'express';
import { OrderService } from './application/services/OrderService';
import { DynamoOrderRepository } from './infrastructure/repositories/DynamoOrderRepository';
import orderRoutes from './routes/orderRoutes';

export const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const orderRepository = new DynamoOrderRepository();
const orderService = new OrderService(orderRepository);

app.use('/', orderRoutes(orderService));

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error('Error no manejado:', err);
    res.status(500).json({
        error: 'Error interno del servidor',
        message: err.message
    });
});

app.get('/health', (req: Request, res: Response) => {
    res.status(200).json({ status: 'OK' });
});