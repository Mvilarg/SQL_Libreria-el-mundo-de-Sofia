# Documentación de la Base de Datos: Librería El Mundo de Sofía

## 1. Justificación del Diseño

El diseño de la base de datos para la **Librería El Mundo de Sofía** se ha estructurado bajo el modelo relacional normalizado para garantizar la integridad de los datos, evitar la redundancia y optimizar las operaciones de inventario, ventas y gestión de clientes. 

El esquema se compone de 7 tablas principales interconectadas de manera lógica:

*   **Gestión de Catálogo (`Libros` y `Autores`):** Se separó la información de los libros de la de sus creadores debido a que un libro puede ser escrito por varios autores y un autor puede redactar múltiples obras. Esta relación de muchos a muchos (N:M) se resuelve mediante la tabla intermedia **`Libro_autor`**.
*   **Gestión de Clientes (`Clientes`):** Almacena la información de contacto de los compradores de forma independiente, permitiendo asociarlos directamente con sus compras históricas.
*   **Gestión Comercial (`Pedidos` y `Detalle_pedido`):** Las compras se dividen en dos niveles. La tabla **`Pedidos`** funge como la cabecera general (fecha, estado y cliente), mientras que **`Detalle_pedido`** desglosa los ítems específicos comprados. Esta separación permite registrar cantidades exactas y guardar el `precio_unitario` histórico del libro al momento de la venta.
*   **Control Financiero (`Transacciones`):** Se independizó el registro de los pagos en la tabla **`Transacciones`**, vinculándola directamente al pedido para manejar de forma clara el método de pago y el monto total cancelado.

---

## 2. Restricciones y Validaciones

Para mantener la consistencia y el comportamiento esperado del sistema, se implementaron las siguientes restricciones a nivel de estructura:

### Claves Primarias (Primary Keys - PK)
Cada tabla cuenta con un identificador único numérico autoincremental (`AUTO_INCREMENT`) que garantiza la unicidad de cada registro:
*   `Libros`: `idLibro`
*   `Autores`: `idAutor`
*   `Clientes`: `idCliente`
*   `Pedidos`: `idPedido`
*   `Detalle_pedido`: `idDetalle_pedido`
*   `Transacciones`: `idTransacciones`

### Claves Foráneas (Foreign Keys - FK)
Las relaciones lógicas del negocio están blindadas mediante restricciones de integridad referencial:
*   **`Libro_autor`**: Relaciona `idLibro` con la tabla `Libros` e `idAutor` con la tabla `Autores`.
*   **`Pedidos`**: Contiene `idCliente` referenciando a la tabla `Clientes`.
*   **`Detalle_pedido`**: Conecta cada línea de compra referenciando `idLibro` (de `Libros`) e `idPedido` (de `Pedidos`).
*   **`Transacciones`**: Asocia el pago al pedido correspondiente mediante la clave foránea `idPedido` referenciando a la tabla `Pedidos`.

### Validaciones y Tipos de Datos
*   **Campos Obligatorios (`NOT NULL`):** Se aplicaron en campos críticos como títulos, nombres, precios, cantidades y fechas para impedir registros incompletos.
*   **Valores por Defecto (`DEFAULT`):** El campo `stock` en la tabla `Libros` incluye un valor por defecto de `0` para evitar errores de nulos al inicializar productos.
*   **Precisión Temporal:** Se utilizaron tipos de datos `DATETIME` en lugar de `DATE` simple en las fechas de compra, publicación y transacciones para permitir datos precisos basados en horas, minutos y segundos.

---

## 3. Relaciones UML

El diagrama de entidad-relación (E-R) refleja las siguientes cardinalidades y reglas de asociación:

*   **Relación Libros ↔ Autores (Muchos a Muchos - `N:M`):** 
    Implementada a través de la tabla asociativa `Libro_autor`. Un registro en `Libros` puede asociarse con uno o más registros en `Autores`, y viceversa.
*   **Relación Clientes ↔ Pedidos (Uno a Muchos - `1:N`):** 
    Un cliente (`Clientes`) puede realizar múltiples pedidos a lo largo del tiempo, pero cada pedido generado pertenece de forma exclusiva a un único cliente.
*   **Relación Pedidos ↔ Libros (Muchos a Muchos - `N:M` a través de `Detalle_pedido`):** 
    Un pedido puede incluir múltiples libros diferentes y un libro puede formar parte de distintos pedidos realizados por diferentes clientes.
*   **Relación Pedidos ↔ Transacciones (Uno a Uno / Uno a Muchos - `1:1`):** 
    Cada pedido completado genera un registro de pago asociado en la tabla `Transacciones` a través de la clave foránea `idPedido`, documentando el método de pago y el monto total de la operación.