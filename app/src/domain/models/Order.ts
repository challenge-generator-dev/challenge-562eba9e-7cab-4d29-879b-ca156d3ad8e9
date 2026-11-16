import { OrderStatus } from './OrderStatus';
import { ProductDetails } from './ProductDetails';

export interface Order {
    id: string;
    status: OrderStatus;
    createdAt: string;
    productDetails: ProductDetails;
}

export interface OrderCreateDto {
    productDetails: ProductDetails;
}

export interface OrderUpdateDto {
    status?: OrderStatus;
    productDetails?: ProductDetails;
}

export { OrderStatus } from './OrderStatus';
export { ProductDetails } from './ProductDetails';