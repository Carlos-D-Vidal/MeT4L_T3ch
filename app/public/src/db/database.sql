-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28/01/2025 às 18:28
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `database`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(60) NOT NULL,
  `codigo` int(11) NOT NULL,
  `natureza` enum('PF','PJ') NOT NULL,
  `cnpj_cpf` int(11) NOT NULL,
  `rg` int(11) NOT NULL,
  `nascimento` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_municipio` int(11) NOT NULL,
  `ie` int(11) NOT NULL,
  `bairro` varchar(60) NOT NULL,
  `numero` int(11) NOT NULL,
  `logradouro` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `pacote_promocao` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome_cliente`, `codigo`, `natureza`, `cnpj_cpf`, `rg`, `nascimento`, `id_municipio`, `ie`, `bairro`, `numero`, `logradouro`, `email`, `pacote_promocao`, `status`) VALUES
(1, 'Lucas', 0, 'PF', 0, 0, '2025-01-24 22:46:11', 0, 0, '', 0, '', '', 0, ''),
(2, 'Carlos', 0, 'PF', 0, 0, '2025-01-24 22:46:11', 0, 0, '', 0, '', '', 0, ''),
(3, 'Rafael', 0, 'PF', 0, 0, '2025-01-24 22:46:11', 0, 0, '', 0, '', '', 0, ''),
(4, 'Nairo', 0, 'PF', 0, 0, '2025-01-24 22:46:11', 0, 0, '', 0, '', '', 0, ''),
(5, 'Alex', 0, 'PF', 0, 0, '2025-01-24 22:46:11', 0, 0, '', 0, '', '', 0, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `forma_pagamento`
--

CREATE TABLE `forma_pagamento` (
  `id_forma_pagamento` int(11) NOT NULL,
  `desc_forma_pagamento` varchar(30) NOT NULL,
  `id_tipo_recebimento` int(11) NOT NULL,
  `permite_parcelamento` char(1) NOT NULL,
  `qtd_max_parcelas` int(11) NOT NULL,
  `status` char(1) NOT NULL,
  `codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `forma_pagamento`
--

INSERT INTO `forma_pagamento` (`id_forma_pagamento`, `desc_forma_pagamento`, `id_tipo_recebimento`, `permite_parcelamento`, `qtd_max_parcelas`, `status`, `codigo`) VALUES
(1, 'Pix', 0, 'N', 1, '', 0),
(2, 'Credito', 0, 'S', 12, '', 0),
(3, 'Debito', 0, 'N', 1, '', 0),
(4, 'Boleto', 0, 'N', 12, '', 0),
(5, 'Dinheiro', 0, 'N', 1, '', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `item`
--

CREATE TABLE `item` (
  `id_item` int(11) NOT NULL,
  `desc_item` varchar(60) NOT NULL,
  `preco_item` double(11,2) NOT NULL,
  `quant_item` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `codigo_barra` varchar(30) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `registra_comissao` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `item`
--

INSERT INTO `item` (`id_item`, `desc_item`, `preco_item`, `quant_item`, `codigo`, `codigo_barra`, `id_categoria`, `registra_comissao`, `status`) VALUES
(1, 'Elden Ring', 299.90, 10, 0, '', 0, 0, ''),
(2, 'Dark Souls III', 120.00, 10, 0, '', 0, 0, ''),
(3, 'Undertale', 19.90, 10, 0, '', 0, 0, ''),
(4, 'Deltarune', 29.90, 10, 0, '', 0, 0, ''),
(5, 'Omori', 16.90, 10, 0, '', 0, 0, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `item_venda`
--

CREATE TABLE `item_venda` (
  `id_item_venda` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `id_venda` int(11) NOT NULL,
  `quant` int(11) NOT NULL,
  `preco` double(11,2) NOT NULL,
  `total` double(11,2) NOT NULL,
  `desconto` int(11) NOT NULL,
  `acrescimo` int(11) NOT NULL,
  `data_venda` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `recebimento_venda`
--

CREATE TABLE `recebimento_venda` (
  `id_recebimento` int(11) NOT NULL,
  `id_venda` int(11) NOT NULL,
  `id_forma_pagamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sys_log_registro`
--

CREATE TABLE `sys_log_registro` (
  `id_sys_log` int(11) NOT NULL,
  `id_tipo_operacao` int(11) NOT NULL,
  `table_name` varchar(60) NOT NULL,
  `query` text NOT NULL,
  `id_usuario_registro` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_operacao`
--

CREATE TABLE `tipo_operacao` (
  `id_tipo_operacao` int(11) NOT NULL,
  `denominacao` varchar(30) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_recebimento`
--

CREATE TABLE `tipo_recebimento` (
  `id_tipo_recebimento` int(11) NOT NULL,
  `desc_tipo_recebimento` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `desc_usuario` varchar(30) NOT NULL,
  `login` varchar(60) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `desc_usuario`, `login`, `id_tipo_usuario`, `status`) VALUES
(1, 'admin', '', 0, ''),
(2, 'comum', '', 0, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `venda`
--

CREATE TABLE `venda` (
  `id_venda` int(11) NOT NULL,
  `status_venda` char(1) NOT NULL,
  `data_venda` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_venda` double(11,2) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `numero_venda` int(11) NOT NULL,
  `total_item` int(11) NOT NULL,
  `desconto` int(11) NOT NULL,
  `acrescimo` int(11) NOT NULL,
  `observacao` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  ADD PRIMARY KEY (`id_forma_pagamento`);

--
-- Índices de tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id_item`);

--
-- Índices de tabela `item_venda`
--
ALTER TABLE `item_venda`
  ADD PRIMARY KEY (`id_item_venda`);

--
-- Índices de tabela `recebimento_venda`
--
ALTER TABLE `recebimento_venda`
  ADD PRIMARY KEY (`id_recebimento`);

--
-- Índices de tabela `sys_log_registro`
--
ALTER TABLE `sys_log_registro`
  ADD PRIMARY KEY (`id_sys_log`);

--
-- Índices de tabela `tipo_recebimento`
--
ALTER TABLE `tipo_recebimento`
  ADD PRIMARY KEY (`id_tipo_recebimento`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Índices de tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`id_venda`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  MODIFY `id_forma_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `item`
--
ALTER TABLE `item`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `item_venda`
--
ALTER TABLE `item_venda`
  MODIFY `id_item_venda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `recebimento_venda`
--
ALTER TABLE `recebimento_venda`
  MODIFY `id_recebimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sys_log_registro`
--
ALTER TABLE `sys_log_registro`
  MODIFY `id_sys_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_recebimento`
--
ALTER TABLE `tipo_recebimento`
  MODIFY `id_tipo_recebimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `venda`
--
ALTER TABLE `venda`
  MODIFY `id_venda` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
