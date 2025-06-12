# 1. Tipos de ubicaci?n de datos para strings en Solidity

### `memory`:

- Temporal, existe solo durante la ejecuci?n de la funci?n.
- Es modificable dentro de la funci?n.
- Se usa para par?metros o variables temporales.

### `storage`:

- Persistente, se guarda en el estado del contrato en la blockchain.
- Se usa para variables de estado.

### `calldata` (supongo que quer?as decir `calldata` y no `input data`):

- Solo lectura, inmutable.
- Es la ubicaci?n por defecto para los par?metros externos en funciones `external`.
- M?s eficiente que `memory` para inputs de funci?n.

---

# 2. `override` y `virtual` en Solidity

Cuando quieres sobrescribir (`override`) una funci?n heredada de un contrato padre:

- En el contrato padre, la funci?n debe declararse con la palabra clave `virtual` para indicar que puede ser sobreescrita.
- En el contrato hijo, la funci?n que la reemplaza debe usar la palabra clave `override`.

### Ejemplo:

```solidity
contract Padre {
    function saludar() public virtual returns (string memory) {
        return "Hola desde Padre";
    }
}

contract Hijo is Padre {
    function saludar() public override returns (string memory) {
        return "Hola desde Hijo";
    }
}
```

---

# 3. Or?culos en Solidity

Un **or?culo** permite que un contrato inteligente obtenga informaci?n externa (fuera de la blockchain).

### Usos t?picos de un or?culo:

1. **Generar un n?mero aleatorio** de forma segura (por ejemplo, usando Chainlink VRF).
2. **Consultar informaci?n off-chain**, como el precio de un token o la temperatura de una ciudad.
3. **Consultar APIs personalizadas**, para interactuar con servicios externos o bases de datos privadas.

> ?? Los contratos inteligentes por s? solos no pueden acceder directamente a datos externos. Por eso se necesitan or?culos.

---

# 4. Librer?as (`library`) en Solidity

Las **librer?as** son contratos reutilizables que contienen funciones auxiliares.

### C?mo se crean:

```solidity
library MathLib {
    function suma(uint a, uint b) internal pure returns (uint) {
        return a + b;
    }
}
```

### C?mo se declaran:

Puedes usarlas con `using ... for` o llamarlas directamente con `NombreLibrer?a.funci?n(...)`.

```solidity
using MathLib for uint;

contract MiContrato {
    function calcular() public pure returns (uint) {
        return 3.suma(4); // equivalente a MathLib.suma(3, 4)
    }
}
```

### C?mo se pasan los par?metros:

Cuando usas `using MathLib for uint;`, el n?mero (por ejemplo, `3`) se pasa como **primer argumento impl?cito** a la funci?n:

```solidity
function suma(uint self, uint otro) internal pure returns (uint) {
    return self + otro; // self = 3, otro = 4
}
```

Tambi?n puedes usar directamente:

```solidity
MathLib.suma(3, 4);
```

---

# 5. Mapping en Solidity

Un `mapping` es una estructura clave-valor similar a un diccionario.

### Sintaxis:

```solidity
mapping(KeyType => ValueType) nombre;
```

### Ejemplo b?sico:

```solidity
mapping(address => uint) public saldos;

function depositar() public payable {
    saldos[msg.sender] += msg.value;
}

function consultarSaldo(address usuario) public view returns (uint) {
    return saldos[usuario];
}
```

- `msg.sender` act?a como clave.
- Se puede acceder como `saldos[usuario]`.
- Si nunca se ha asignado un valor, devuelve el valor por defecto (ej. `0`).

### Cosas importantes sobre los mappings:

- No se pueden iterar.
- No se puede obtener una lista de claves.
- Se pueden anidar: `mapping(uint => mapping(address => bool))`.

---
