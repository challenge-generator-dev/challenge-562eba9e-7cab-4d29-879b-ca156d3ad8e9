// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Order } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { PutItemCommand, GetItemCommand, UpdateItemCommand, DeleteItemCommand } from '@aws-sdk/client-dynamodb';
import { marshall, unmarshall } from '@aws-sdk/util-dynamodb';
import { injectable } from 'inversify';

@injectable()
export class DynamoOrderRepository implements OrderRepository {
    private readonly client: DynamoDBClient;
    private readonly tableName: string;

    constructor() {
        this.client = new DynamoDBClient({ region: process.env.AWS_REGION });
        this.tableName = process.env.DYNAMODB_TABLE_NAME || 'Orders';
    }

    async create(order: Order): Promise<Order> {
      throw new Error('TODO(reto): create');
    }

    async findById(id: string): Promise<Order | null> {
      throw new Error('TODO(reto): findById');
    }

    async update(id: string, order: Partial<Order>): Promise<Order> {
      throw new Error('TODO(reto): update');
    }

    async delete(id: string): Promise<void> {
      throw new Error('TODO(reto): delete');
    }
}