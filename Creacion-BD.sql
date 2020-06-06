--Creación de la base de datos
create database zapateria;

use zapateria;

--Creación de la tabla PAISES
create table PAISES(
	id int primary key identity(1,1),
	nombre varchar(50) not null
);

--Creación de la tabla CLIENTES
create table CLIENTES(
	id int primary key identity(1,1),
	nombre varchar(50) not null,
	id_pais int foreign key references PAISES(id)
);

--Creación de la tabla PRODUCTOS
create table PRODUCTOS(
	id int primary key identity(1,1),
	nombre varchar(50) not null,
	presentacion varchar(50),
	valor money,
	stock int default 0
);

--creación de la tabla FACTURAS
create table FACTURAS(
	id int primary key identity(1,1),
	id_cliente int foreign key references CLIENTES(id),
	impuesto money default 0,
	descuento int default 0,
	total money default 0,
	fecha date
);

create table FACTURA_DETALLES(
	id_factura int foreign key references FACTURAS(id),
	id_producto int foreign key references PRODUCTOS(id),
	cantidad int,
	total money,
	primary key(id_factura, id_producto)
);

--creación de la tabla INVENTARIO
create table INVENTARIO(
	id int primary key identity (1,1),
	id_producto int foreign key references PRODUCTOS(id),
	tipo_movimiento varchar(10),
	fecha date,
	cantidad int
);

go
--triggers

--Trigger para la actualización del total de la factura
--con respecto al inventario
--la cual contiene la lista de productos
create or alter trigger trg_factura_detalles
on FACTURA_DETALLES
AFTER INSERT, update
as
begin
	update FACTURA_DETALLES
	set total = cantidad * precio
	from (
		select id as p, valor as precio
		from PRODUCTOS
	) P
	where id_producto = p;

	update FACTURAS
	set total = total + total_detalles - total_detalles*descuento/100
	from (
		select id_factura as f, SUM(total) as total_detalles
		from FACTURA_DETALLES
		group by id_factura
	) A
	where id = f;
end;
go

-- Trigger para insertar las salidas en el inventario
-- luego de realizar una venta
create or alter trigger insert_inventario
on FACTURA_DETALLES
after insert
as
begin
	insert into INVENTARIO (id_producto, tipo_movimiento, fecha, cantidad)
	select i.id_producto, 'SALIDA', F.fecha, i.cantidad
	from inserted i, (select id, fecha 
						from FACTURAS) F
	where i.id_factura = F.id;
end;
go

--Trigger para actualizar stock de productos
--Luego del ingreso o salida de productos del inventario
create or alter trigger actualizar_stock
on INVENTARIO
after insert
as
begin
	update PRODUCTOS
	set stock = stock - cantidad_producto
	from (
		select id_producto, tipo_movimiento, cantidad as cantidad_producto
		from inserted
	) A
	where id = id_producto 
		and UPPER(tipo_movimiento) = 'SALIDA';
	
	update PRODUCTOS
	set stock = stock + cantidad_producto
	from (
		select id_producto, tipo_movimiento, cantidad as cantidad_producto
		from inserted
	) A
	where id = id_producto 
		and UPPER(tipo_movimiento) = 'ENTRADA';
end;
go

-- Trigger para setear el impuesto de la factura
create or alter trigger set_impuesto
on FACTURAS
after update
as
begin
	update FACTURAS
	set impuesto = 0.18*total;
end;
go