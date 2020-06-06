-- Inserción de Países
use zapateria;

insert into PAISES (nombre) 
values ('Perú'), ('Colombia'), 
		('Vanezuela'), ('Argentina');

-- Inserción de Clientes
insert into CLIENTES (nombre, id_pais) 
values ('Jose', 1), ('Erick', 2), 
		('Joel', 1), ('Juan', 3),
		('Maria', 3), ('Ale', 4),
		('Rubi', 1), ('Manuel', 3);

-- Inserción de Productos
insert into PRODUCTOS (nombre, presentacion, valor, stock)
values ('zapatillas urbana', 'caja', 160.00, 20),
		('zapatillas nike 60', 'caja', 120.00, 10),
		('zapatillas puma 10', 'caja', 130.00, 15);

-- Inserción de Inventario entrada
insert into INVENTARIO (id_producto, tipo_movimiento, cantidad, fecha)
values (1, 'ENTRADA', 5, '05/01/2020'),
		(2, 'ENTRADA', 5, '05/01/2020'),
		(1, 'ENTRADA', 5, '05/01/2020'),
		(2, 'ENTRADA', 5, '05/01/2020'),
		(1, 'SALIDA', 1, '05/01/2020'),
		(3, 'SALIDA', 1, '05/01/2020'),
		(1, 'SALIDA', 1, '05/01/2020'),
		(3, 'SALIDA', 1, '05/01/2020');

-- Inserción de Factura
insert into FACTURAS (id_cliente, descuento, fecha)
values (1,10,'05/01/2020'),
		(2,10,'05/02/2020'),
		(3,10,'10/02/2020'),
		(4,10,'10/20/2020');

-- Inserción de FACTURA_DETALLES
insert into FACTURA_DETALLES (id_factura, id_producto, cantidad)
values (1, 1, 5),
		(1, 2, 5),
		(2, 1, 5),
		(2, 2, 5),
		(3, 1, 1),
		(3, 3, 1),
		(4, 1, 1),
		(4, 3, 1);