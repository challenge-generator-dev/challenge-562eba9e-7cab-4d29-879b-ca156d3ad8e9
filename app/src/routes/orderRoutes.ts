// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Router, Request, Response } from 'express';
import { OrderController } from '../infrastructure/controllers/OrderController';
import { OrderService } from '../application/services/OrderService';
import { body, param } from 'express-validator';

const router = Router();

export const OrderRoutes = (orderService: OrderService): Router => {
    const orderController = new OrderController(orderService);

    router.post(
        '/orders',
        [
            body('productDetails.productId').isString().notEmpty(),
            body('productDetails.quantity').isInt({ min: 1 }),
            body('productDetails.price').isFloat({ min: 0 })
        ],
        (req: Request, res: Response) => orderController.createOrder(req, res)
    );

    router.get(
        '/orders/:id',
        [
            param('id').isString().notEmpty()
        ],
        (req: Request, res: Response) => orderController.getOrder(req, res)
    );

    router.put(
        '/orders/:id',
        [
            param('id').isString().notEmpty(),
            body('status').optional().isIn(['PENDING', 'COMPLETED', 'CANCELLED']),
            body('productDetails').optional(),
            body('productDetails.productId').optional().isString().notEmpty(),
            body('productDetails.quantity').optional().isInt({ min: 1 }),
            body('productDetails.price').optional().isFloat({ min: 0 })
        ],
        (req: Request, res: Response) => orderController.updateOrder(req, res)
    );

    router.delete(
        '/orders/:id',
        [
            param('id').isString().notEmpty()
        ],
        (req: Request, res: Response) => orderController.deleteOrder(req, res)
    );

    return router;
};

export default router;