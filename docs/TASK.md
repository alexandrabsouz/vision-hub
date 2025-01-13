# CONSIDERAÇÕES FINAIS E DE MELHORIA

# Database:
- [x] Users Table
- [x] Devices Table

# Seeds:
- [x] Users with 50 devices
- [x] Performance

# Enpoints:
- [x] GET Devices /devices
- [x] POST /notify-users with dev/mailbox


1. Não acredito que estaria pronto pra deploy sem o mínimo do crud de usuarios ao menos.
2. Deveria existir um job que verifica se o usuário foi desativado e desativa os dispositivos ligados a seu user_id.

## Seeds 

O seeds foi testado com 3 pré-disposições diferentes, as imagens estão guardadas no documento e se quiser pode averiguar tambem, o jeito mais rapido entre os testes foi aplicado.

## Rotas
Todas as rotas se alinham com os critérios mensionados, só a rota que tras os usuarios e cameras que nao achei diferença entre as desativadas e não desativadas no payload de retorno então o payload vem completo e a unica diferença é se tem algo no campo mostrando a hora que foi desativado ou não (Não é muito seguro, deveria ter o usuario de quem desativou tambem para não ter depois caça culpados ja que todas as cameras serão desativadas.)

## Sobre o teste: 

Me pegaram bonito, parece simples e facil num nivel "Bobo", mas quando vamos aplicar demora um pouco mais de tempo, gostei! Mas pensem com carinho a aplicação da questão da configuração do Oban.