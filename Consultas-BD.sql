use zapateria;

-- Consulta la factutación de un cliente en específico
-- en este caso un cliente con id = 1
select *
from FACTURAS
where id_cliente = 1;

-- Consulta la facturación de un producto en específico
-- en este caso un producto con id = 2
select FD.id_producto as Producto, P.nombre as Nombre,
		FD.cantidad as Cantidad, FD.total as Total, F.fecha as Fecha
from PRODUCTOS P, FACTURA_DETALLES FD, FACTURAS F
where P.id = 2 and FD.id_producto = P.id and F.id = FD.id_factura;

-- Consulta de la facturación de un rango de fechas
-- fechas 2020-01-01 - 2020-06-30
select *
from FACTURAS
where fecha between '2020-01-01' and '2020-12-31'

-- Consulta de los clientes que han comprado
-- por lo menos una vez
select C.id as 'ID', C.nombre as 'Nombre', p.nombre as 'Pais'
from FACTURAS F, CLIENTES C, PAISES P
where C.id = F.id_cliente and c.id_pais = p.id
group by c.id, c.nombre, p.nombre