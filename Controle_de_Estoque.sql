CREATE OR REPLACE FUNCTION register_order(
    customer_id INT,
    product_id INT,
    quantity INT
)
RETURNS VOID AS $$
DECLARE
    stock INT;
BEGIN
    -- Verificação da quantidade em estoque (com lock para evitar condição de corrida)
    SELECT stock_quantity INTO stock
    FROM products
    WHERE id = product_id
    FOR UPDATE;

    IF stock IS NULL THEN
        RAISE EXCEPTION 'produto não encontrado!';
    END IF;

    IF stock >= quantity THEN
        INSERT INTO orders (customer_id, product_id, quantity, order_date)
        VALUES (customer_id, product_id, quantity, NOW());

        -- Atualizar estoque
        UPDATE products
        SET stock_quantity = stock_quantity - quantity
        WHERE id = product_id;
    ELSE
        -- Caso não haja estoque suficiente
        RAISE EXCEPTION 'estoque insuficiente!';
    END IF;
END;
$$ LANGUAGE plpgsql;