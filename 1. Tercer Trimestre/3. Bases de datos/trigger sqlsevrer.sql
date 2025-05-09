CREATE TABLE Productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    stock INT
);

INSERT INTO Productos (id_producto, nombre, stock) VALUES
(1, 'Aceite de motor', 200),
(2, 'Filtro de aire', 50),
(3, 'Llantas', 30);

CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY IDENTITY,
    id_producto INT,
    cantidad INT,
    fecha DATETIME 
);

alter table ventas 
add FOREIGN KEY (id_producto)
REFERENCES Productos(id_producto)

-- 4. Crear trigger para descontar stock automáticamente al insertar venta
CREATE TRIGGER trg_ActualizarStock
ON Ventas
AFTER INSERT
AS
BEGIN
   
    UPDATE P
    SET P.stock = P.stock - I.cantidad
    FROM Productos P
    INNER JOIN inserted I ON P.id_producto = I.id_producto;
END;

INSERT INTO Ventas (id_producto, cantidad, fecha) VALUES (1, 5, GETDATE());