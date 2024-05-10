# A arquitetura limpa
13 de agosto de 2012

Nos últimos anos, vimos uma grande variedade de ideias relacionadas à arquitetura de sistemas. Essas ideias incluem:

- Arquitetura Hexagonal (também conhecida como Ports and Adapters) de Alistair Cockburn e adotada por Steve Freeman e Nat Pryce em seu maravilhoso livro Growing Object Oriented Software
- Arquitetura da cebola por Jeffrey Palermo
- Screaming Architecture de um blog meu no ano passado
- DCI de James Coplien e Trygve Reenskaug.
- BCE por Ivar Jacobson em seu livro Object Oriented Software Engineering (Engenharia de software orientada a objetos): A Use-Case Driven Approach (Uma abordagem orientada a casos de uso)
- Embora todas essas arquiteturas variem um pouco em seus detalhes, elas são muito semelhantes. Todas elas têm o mesmo objetivo, que é a separação das preocuapações. Todas elas conseguem essa separação dividindo o software em camadas. Cada uma tem pelo menos uma camada para regras de negócios e outra para interfaces.

Cada uma dessas arquiteturas produz sistemas que são:

1. Independente de estruturas. A arquitetura não depende da existência de alguma biblioteca de software repleta de recursos. Isso permite que você use essas estruturas como ferramentas, em vez de ter que amontoar seu sistema em suas restrições limitadas.
2. Testável. As regras de negócios podem ser testadas sem a interface do usuário, o banco de dados, o servidor da Web ou qualquer outro elemento externo.
3. Independente da interface do usuário. A interface do usuário pode mudar facilmente, sem alterar o restante do sistema. Uma UI da Web pode ser substituída por uma UI de console, por exemplo, sem alterar as regras comerciais.
4. Independente do banco de dados. Você pode trocar o Oracle ou o SQL Server pelo Mongo, BigTable, CouchDB ou qualquer outro. Suas regras de negócios não estão vinculadas ao banco de dados.
5. Independente de qualquer agência externa. Na verdade, suas regras de negócios simplesmente não sabem nada sobre o mundo externo.


O diagrama na parte superior deste artigo é uma tentativa de integrar todas essas arquiteturas em uma única ideia acionável.

## A regra de dependência
Os círculos concêntricos representam diferentes áreas do software. Em geral, quanto mais você avança, mais alto é o nível do software. Os círculos externos são mecanismos. Os círculos internos são políticas.
A regra primordial que faz essa arquitetura funcionar é a Regra da Dependência. Essa regra diz que as dependências do código-fonte só podem apontar para dentro. Nada em um círculo interno pode saber absolutamente nada sobre algo em um círculo externo. Em particular, o nome de algo declarado em um círculo externo não deve ser mencionado pelo código em um círculo interno. Isso inclui funções, classes, variáveis ou qualquer outra entidade de software nomeada.
Da mesma forma, os formatos de dados usados em um círculo externo não devem ser usados por um círculo interno, especialmente se esses formatos forem gerados por uma estrutura em um círculo externo. Não queremos que nada em um círculo externo afete os círculos internos.

### Entidades
As entidades encapsulam as regras comerciais de toda a empresa. Uma entidade pode ser um objeto com métodos ou pode ser um conjunto de estruturas de dados e funções. Isso não importa, desde que as entidades possam ser usadas por muitos aplicativos diferentes na empresa.
Se você não tem uma empresa e está apenas escrevendo um único aplicativo, essas entidades são os objetos de negócios do aplicativo. Elas encapsulam as regras mais gerais e de alto nível. São as menos propensas a mudar quando algo externo muda. Por exemplo, você não esperaria que esses objetos fossem afetados por uma alteração na navegação da página ou na segurança. Nenhuma alteração operacional em um aplicativo específico deve afetar a camada de entidade.

## Casos de uso
O software nessa camada contém regras comerciais específicas do aplicativo. Ele encapsula e implementa todos os casos de uso do sistema. Esses casos de uso orquestram o fluxo de dados de e para as entidades e orientam essas entidades a usar as regras de negócios de toda a empresa para atingir os objetivos do caso de uso.
Não esperamos que as alterações nessa camada afetem as entidades. Também não esperamos que essa camada seja afetada por alterações nas externalidades, como o banco de dados, a interface do usuário ou qualquer uma das estruturas comuns. Essa camada está isolada de tais preocupações.
No entanto, esperamos que as alterações na operação do aplicativo afetem os casos de uso e, portanto, o software nessa camada. Se os detalhes de um caso de uso mudarem, algum código nessa camada certamente será afetado.

## Adaptadores de interface
O software nessa camada é um conjunto de adaptadores que convertem os dados do formato mais conveniente para os casos de uso e as entidades para o formato mais conveniente para algum órgão externo, como o banco de dados ou a Web. É essa camada, por exemplo, que conterá totalmente a arquitetura MVC de uma GUI. Os apresentadores, as visualizações e os controladores pertencem todos a essa camada. Os modelos provavelmente são apenas estruturas de dados que são passadas dos controladores para os casos de uso e, depois, de volta dos casos de uso para os apresentadores e visualizações.
Da mesma forma, os dados são convertidos, nessa camada, da forma mais conveniente para entidades e casos de uso para a forma mais conveniente para qualquer estrutura de persistência que esteja sendo usada, ou seja, o banco de dados. Nenhum código dentro desse círculo deve saber absolutamente nada sobre o banco de dados. Se o banco de dados for um banco de dados SQL, todo o SQL deverá ser restrito a essa camada e, em particular, às partes dessa camada que têm a ver com o banco de dados.
Também nessa camada está qualquer outro adaptador necessário para converter dados de algum formato externo, como um serviço externo, para o formato interno usado pelos casos de uso e entidades.

## Estruturas e acionadores.
A camada mais externa é geralmente composta de estruturas e ferramentas, como o banco de dados, a estrutura da Web etc. Em geral, você não escreve muito código nessa camada, a não ser o código de cola que se comunica com o próximo círculo para dentro.
É nessa camada que ficam todos os detalhes. A Web é um detalhe. O banco de dados é um detalhe. Mantemos essas coisas do lado de fora, onde elas podem causar pouco dano.
Apenas quatro círculos?
Não, os círculos são esquemáticos. Você pode achar que precisa de mais do que apenas esses quatro. Não há nenhuma regra que diga que você sempre deve ter apenas esses quatro. Entretanto, a Regra da Dependência sempre se aplica. As dependências do código-fonte sempre apontam para dentro. À medida que você avança para dentro, o nível de abstração aumenta. O círculo mais externo é o detalhe concreto de baixo nível. À medida que você avança, o software se torna mais abstrato e encapsula políticas de nível mais alto. O círculo mais interno é o mais geral.

## Cruzando fronteiras.
No canto inferior direito do diagrama há um exemplo de como cruzamos os limites do círculo. Ele mostra os Controllers e Presenters se comunicando com os Use Cases na próxima camada. Observe o fluxo de controle. Ele começa no controlador, passa pelo caso de uso e acaba sendo executado no apresentador. Observe também as dependências do código-fonte. Cada uma delas aponta para dentro, para os casos de uso.
Normalmente, resolvemos essa aparente contradição usando o Princípio da Inversão de Dependência. Em uma linguagem como Java, por exemplo, organizaríamos as interfaces e as relações de herança de modo que as dependências do código-fonte se opusessem ao fluxo de controle nos pontos certos da fronteira.
Por exemplo, considere que o caso de uso precisa chamar o apresentador. Entretanto, essa chamada não deve ser direta, pois isso violaria a Regra de Dependência: Nenhum nome em um círculo externo pode ser mencionado por um círculo interno. Portanto, fazemos com que o caso de uso chame uma interface (mostrada aqui como Use Case Output Port) no círculo interno e fazemos com que o apresentador no círculo externo a implemente.
A mesma técnica é usada para ultrapassar todos os limites das arquiteturas. Aproveitamos o polimorfismo dinâmico para criar dependências de código-fonte que se opõem ao fluxo de controle, de modo que possamos estar em conformidade com a Regra da Dependência, independentemente da direção do fluxo de controle.

## Quais dados ultrapassam os limites.
Normalmente, os dados que cruzam os limites são estruturas de dados simples. Você pode usar structs básicos ou objetos simples de transferência de dados, se desejar. Ou os dados podem ser simplesmente argumentos em chamadas de função. Ou você pode empacotá-los em um hashmap ou construí-los em um objeto. O importante é que estruturas de dados simples e isoladas sejam transmitidas através dos limites. Não queremos trapacear e passar entidades ou linhas de banco de dados. Não queremos que as estruturas de dados tenham qualquer tipo de dependência que viole a Regra da Dependência.
Por exemplo, muitas estruturas de banco de dados retornam um formato de dados conveniente em resposta a uma consulta. Podemos chamar isso de RowStructure. Não queremos passar essa estrutura de linha para dentro de um limite. Isso violaria a Regra de Dependência porque forçaria um círculo interno a saber algo sobre um círculo externo.
Portanto, quando passamos dados através de um limite, eles estão sempre na forma mais conveniente para o círculo interno.

## Conclusão
Estar em conformidade com essas regras simples não é difícil e lhe poupará muitas dores de cabeça no futuro. Ao separar o software em camadas e estar em conformidade com a Regra da Dependência, você criará um sistema que é intrinsecamente testável, com todos os benefícios que isso implica. Quando qualquer uma das partes externas do sistema se tornar obsoleta, como o banco de dados ou a estrutura da Web, você poderá substituir esses elementos obsoletos com o mínimo de esforço.
