# KnightCTF - Knight Switch bank

| Nom | Knight Switch Bank |
| --- | --- |
| Points | 200 |
| Difficulté  | Facile |
| Validation | 173 |

Bonjour, je vous présente aujourd’hui ma writeup sur le challenge de Reverse Knight Switch bank du CTF KnightCTF.

Commençons par le commencement, tout d’abord lançons le binaire.

![Untitled](KnightCTF%20-%20Knight%20Switch%20bank%20925d96a4f7504cb5a23fcb0d7a2d40c0/Untitled.png)

## Analyse et compréhensions du binaire

Lorsque nous lançons le binaire on peut voir qu’il demande un mot de passe. On peut potentiellement en conclure que le mot de passe est en dur dans le code du binaire, mais qu’il y a un algorithme à reverse. C’est partit récupérons le pseudo code.

| Fonctions du binaire |
| --- |
| main |
| winner |

En effet on peut obsérver qu’il existe seulement deux fonctions dans le binaire. En allant voir dans le winner j’ai vu que cela affichait simplement une chaine de caractère m’indiquant que le mot de passe rentré était correct. Nous allons donc analyser la fonction main.

Main: 

```c
undefined8 main(void)
{
    int64_t var_430h;
    int64_t var_230h;
    int64_t var_30h;
    int64_t var_28h;
    int64_t var_20h;
    int64_t var_18h;
    int32_t var_10h;
    char var_9h;
    int32_t var_8h;
    int64_t var_4h;
    
    var_30h = 0x4164485d5549525a;
    var_28h = 0x41494447414a644e;
    var_20h = 0x4173444476414978;
    var_18h._0_4_ = 0x71444479;
    var_18h._4_2_ = 0x5f;
    var_4h._0_4_ = 0;
    var_8h = 0;
    puts(0x402008);
    puts("\tKnight Switch Bank");
    puts(0x402048);
    puts("Welcome to Knight Switch Bank....");
    printf("Please enter your password : ");
    __isoc99_scanf(0x402130, &var_230h);
    for (; *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) != '\0'; var_4h._0_4_ = (int32_t)var_4h + 1) {
        if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'A') ||
           ('M' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
            if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'a') ||
               ('m' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'N') ||
                   ('Z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                    if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'n') ||
                       ('z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0x20;
                    } else {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                    }
                } else {
                    *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                         *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                }
            } else {
                *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                     *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
            }
        } else {
            *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                 *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
        }
    }
    for (; *(char *)((int64_t)&var_430h + (int64_t)var_8h) != '\0'; var_8h = var_8h + 1) {
        *(char *)((int64_t)&var_430h + (int64_t)var_8h) = *(char *)((int64_t)&var_430h + (int64_t)var_8h) + '\x02';
    }
    var_9h = '\0';
    var_10h = 0;
    do {
        if (*(char *)((int64_t)&var_30h + (int64_t)var_10h) == '\0') {
code_r0x00401437:
            if (var_9h == '\0') {
                puts("Oh My God ! You entered a wrong password.");
            } else {
                winner();
            }
            return 0;
        }
        if (*(char *)((int64_t)&var_30h + (int64_t)var_10h) != *(char *)((int64_t)&var_430h + (int64_t)var_10h)) {
            var_9h = '\0';
            goto code_r0x00401437;
        }
        var_9h = '\x01';
        var_10h = var_10h + 1;
    } while( true );
}
```

Voilà donc le contenu de notre fonction main. Je vous propose d’analyser le code étape par étape.

Je vais vous épargner les déclarations de variables ce serait inutile allons directement à l’essentiel.

### 1 ère étape de l’algorithme

```c
		var_30h = 0x4164485d5549525a;
    var_28h = 0x41494447414a644e;
    var_20h = 0x4173444476414978;
    var_18h._0_4_ = 0x71444479;
    var_18h._4_2_ = 0x5f;
    var_4h._0_4_ = 0;
    var_8h = 0;
    puts(0x402008);
    puts("\tKnight Switch Bank");
    puts(0x402048);
    puts("Welcome to Knight Switch Bank....");
    printf("Please enter your password : ");
    __isoc99_scanf(0x402130, &var_230h);
    for (; *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) != '\0'; var_4h._0_4_ = (int32_t)var_4h + 1) {
        if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'A') ||
           ('M' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
            if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'a') ||
               ('m' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'N') ||
                   ('Z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                    if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'n') ||
                       ('z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0x20;
                    } else {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                    }
                } else {
                    *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                         *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                }
            } else {
                *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                     *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
            }
        } else {
            *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                 *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
        }
    }
```

Comme vous pouvez le voir il y a tout d’abord des initialisation de variable on peut donc en conclure assez facilement que ce sont potentiellement les chaines correspondant au flag.

Mais nous verrons à la fin si c’est bien cela.

Ensuite si on lit bien le code on voit qu’il fait un simple scanf il va simplement mettre le contenu que l’on écrit dans le STDIN dans le buffer.

```c
for (; *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) != '\0'; var_4h._0_4_ = (int32_t)var_4h + 1) {
        if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'A') ||
           ('M' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
            if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'a') ||
               ('m' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'N') ||
                   ('Z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                    if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'n') ||
                       ('z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0x20;
                    } else {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                    }
                } else {
                    *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                         *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                }
            } else {
                *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                     *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
            }
        } else {
            *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                 *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
        }
    }
```

En effet rappelez vous notre variable du buffer s’appelle var_230h. Le code ci-dessus est plutot simple nous allons simplement parcourirs la chaine rentré dans le scanf. D’ou la boucle for dans cette boucle il va y avoir des actions très intéressante. Alors écoutez bien.

Tout d’abord la première vérification est super simple il va regarder si la valeur de notre caractère n’est pas comprise entre ‘A’ et ‘M’ si ce n’est pas le cas et bien il va prendre une variable qu’il aura initialisé juste avant la boucle et il y inserera la somme de notre caractère + ‘\r’

```c
*(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                 *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
```

```c
input = 'K' // K est bien dans l'interval de A et M donc il rentrera dans le else

result = ord(input)+ord('\r') // soit 75+13
//=> 88
```

Donc voilà ça c’est l’opération qui ce passera seulement si le caractère est compris entre ‘A’ et ‘M’

En revanche si celui-ci n’est pas contenu entre les deux l’algorithme va rentrer dans une autre condition qui vérifie si idem la lettre n’est pas contenu entre ‘a’ et ‘m’ si tel est le cas il refait la même opération que pour le premier.

Si du coup le caractère n’est pas compris entre ‘a’ et ‘m’ il rentre dans une condition verifiant si le caractère n’est pas compris entre ‘N’ et ‘Z’ si le caractère en question est compris entre ‘N’ et ‘Z’ nous rentrons dans le else.

```c
*(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
              *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
             
```

Rien de bien compliquer, il prend le caractère actuel et il le soustrait à 0xd.

Petit exemple en pseudo code.

```c
input = 'X'
result = ord(input)-0xd // soit 88-0xd ou 88-1
//=> 75
```

Et il fait également la même procédure pour les minuscule. Maintenant si toute ces conditions sont correctes. Il soustrait 0x20 au caracère actuel, c’est dans le cas ou y a des caractères spéciaux.

```c
*(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                     *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0x20;
```

```c
input = '{'

result = ord(input)-0x20 // soit 123-0x20
//=> 91
```

Parfait nous avons donc réussi à comprendre la première étape de l’algorithme.

### 2 ème étape de l’algorithme

La deuxième étape est la plus simple de toute car elle ne comporte que très peu de code.

```c
for (; *(char *)((int64_t)&var_430h + (int64_t)var_8h) != '\0'; var_8h = var_8h + 1) {
    *(char *)((int64_t)&var_430h + (int64_t)var_8h) = 
							*(char *)((int64_t)&var_430h + (int64_t)var_8h) + '\x02';
}
```

Le code est très simple il va simplement parcourir toute la chaine de caractère que l’on a instancié juste avant dans la 1ère étape, il va ensuite simplement remplacer chaque caractère par le caractère actuel+ 2

```c
input = 'A'

res = ord(input)+0x2 // 65+0x20
//=> 67
```

Y a rien de plus à dire sur cette étape c’est tout ce qu’elle fait 🙂.

### 3 ème étape de l’algorithme

Bon nous allons essayer de comprendre la 3 ème et dernière étape de l’algorithme. Elle est toute simple car ce n’est que la partie qui verifie si le flag est bon ou mauvais.

```c
var_9h = '\0';
    var_10h = 0;
    do {
        if (*(char *)((int64_t)&var_30h + (int64_t)var_10h) == '\0') {
code_r0x00401437:
            if (var_9h == '\0') {
                puts("Oh My God ! You entered a wrong password.");
            } else {
                winner();
            }
            return 0;
        }
        if (*(char *)((int64_t)&var_30h + (int64_t)var_10h) != *(char *)((int64_t)&var_430h + (int64_t)var_10h)) {
            var_9h = '\0';
            goto code_r0x00401437;
        }
        var_9h = '\x01';
        var_10h = var_10h + 1;
    } while( true );
```

Je ne vais pas trop m’attarder car le code est relativement compréhensible. Mais en gros on va itérer sur la chaine qui stock une des parties du flag.

Celle-ci:

```c
var_30h = 0x4164485d5549525a;
```

Puis à la fin on verifie sur le caractère actuel du flag est égal au caractère actuel de notre buffer. C’est maintenant qu’on peut en conclure que var_30h et le reste stock bien notre flag. Notre mission si on l’accepte est de reverse l’algorithme.

## Reverse l’algorithme

Ce qui est important dans cet algorithme c’est que l’on va devoir vraiment faire les étapes au sens inverse. C’est à dire que nous allons d’abord devoir reverse la 2 ème step et ensuite la 1 ère pour avoir la chaine final.

Avant tout on sait que notre debut de flag sera forcément KCTF{. On a donc déjà un petit indice pour l’exploitation.

Commençons par prendre le dernier byte de var_30h étant donné que c’est censé être le ‘K’ on va facilement pouvoir comprendre comment reverse.

flag:

```c
var_30h = 0x4164485d5549525a;
```

Donc reprenons notre step 2

```c
for (; *(char *)((int64_t)&var_430h + (int64_t)var_8h) != '\0'; var_8h = var_8h + 1) {
    *(char *)((int64_t)&var_430h + (int64_t)var_8h) = 
							*(char *)((int64_t)&var_430h + (int64_t)var_8h) + '\x02';
}
```

Rappelez vous notre step 2 prend chaque caractère de la chaine final et lui ajoute 2. Il n’y a pas besoin d’un doctorat en mathématique pour comprendre que pour reverse cette step nous allons simplement devoir soustraire 2 à notre byte.

```ruby
byte = 0x5a

print((byte-0x2))
#=>88 soit => 'X'
```

Parfait nous avons reverse la 2 ème step à présent il va falloir simplement que je reverse la 1 ère step c’est partit.

```c
for (; *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) != '\0'; var_4h._0_4_ = (int32_t)var_4h + 1) {
        if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'A') ||
           ('M' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
            if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'a') ||
               ('m' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'N') ||
                   ('Z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                    if ((*(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) < 'n') ||
                       ('z' < *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h))) {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0x20;
                    } else {
                        *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                             *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                    }
                } else {
                    *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                         *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + -0xd;
                }
            } else {
                *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                     *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
            }
        } else {
            *(char *)((int64_t)&var_430h + (int64_t)(int32_t)var_4h) =
                 *(char *)((int64_t)&var_230h + (int64_t)(int32_t)var_4h) + '\r';
        }
    }
```

Donc ce que nous savons de cette partie c’est que si l’on met une lettre majuscule ou minuscule compris entre ‘a’ et ‘m’ et bien nous rentrons dans le else.

On sait que notre premier caractère est forcément ‘K’

Alors bruteforçons voir le quel à la fin obtiendra une lettre cohérente.

```ruby
byte = 0x5a

print((byte-0x2)-13) # on soustrait à notre byte reversé 13 car 13 équivaut à la valeur
# ascii de '\r'
#=> 75 soit 'K'
```

à présent je vous propose donc de scripter tout cela.

### Conception d’un script permettant de reverse l’algorithme

Donc en effet nous avons compris comment reverse les lettres entre ‘A’ et ‘M’ ou a et ‘m’

Le problème est : “Comment je vais savoir quel algorithme appliquer à ma lettre sans savoir à l’avance son range ?”. Rien de plus simple ce que j’ai fais c’est simplement de bruteforce.

Voici un petit exemple:

```ruby
def step2(byte)
		return byte-0x2
end

def algo_range_a_m(byte)
		return (step2(byte)-13)
end

def algo_range_n_z(byte)
		return (step2(byte)+0xd)
end

def step1(byte)
		algo_operation1 = algo_range_a_m(byte)
		algo_operation2 = algo_range_n_z(byte)
		algo_operation3 = (step2(byte)+0x20)
	
		if (algo_operation1 >= 'A'.ord && algo_operation1 <= 'M'.ord) ||(algo_operation1 >= 'a'.ord && algo_operation1 <= 'm'.ord)
        return algo_operation1.chr
    elsif (algo_operation2 >= 'N'.ord && algo_operation2 <= 'Z'.ord) || (algo_operation2 >= 'n'.ord && algo_operation2 <= 'z'.ord)
        return algo_operation2.chr
    else
        return algo_operation3.chr
    end
end
```

Donc pour la petite explication je vais simplement appliquer chaque algorithme à chaque caractère et comparer en gros si par exemple le résultat est dans les ranges si tel est le cas on renvois la valeur correspondant au range.

Voici le script de fin qui reverse nos chaines de caractères. ;)

```ruby
def step2(byte)
    return byte-0x2
end

def algo_range_a_m(byte)
    return (step2(byte)-13)
end

def algo_range_n_z(byte)
    return (step2(byte)+0xd)
end

def step1(byte)
    algo_operation1 = algo_range_a_m(byte)
    algo_operation2 = algo_range_n_z(byte)
    algo_operation3 = (step2(byte)+0x20)

    if (algo_operation1 >= 'A'.ord && algo_operation1 <= 'M'.ord) ||(algo_operation1 >= 'a'.ord && algo_operation1 <= 'm'.ord)
        return algo_operation1.chr
    elsif (algo_operation2 >= 'N'.ord && algo_operation2 <= 'Z'.ord) || (algo_operation2 >= 'n'.ord && algo_operation2 <= 'z'.ord)
        return algo_operation2.chr
    else
        return algo_operation3.chr
    end
end

def main()
    text0 = [0x41,0x64,0x48,0x5d,0x55,0x49,0x52,0x5a].reverse
    text1 = [0x41,0x49,0x44,0x47,0x41,0x4a,0x64,0x4e].reverse
    text2 = [0x41,0x73,0x44,0x44,0x76,0x41,0x49,0x78].reverse
    text3 = [0x71,0x44,0x44,0x79].reverse

    flag = []
    4.times do |i|
        tmp_flag = []

        eval("text#{i}").map.with_index do |byte, j|
            tmp_flag[j] = step1(byte)
        end

        flag[i] = tmp_flag
    end

    puts "Flag: #{flag.join}}"
end

if __FILE__ == $0
    main()
end
```

 

```ruby
Flag: KCTF{So_YoU_ROT_iT_gOOd_jOOb}
```

Sur ce je vous souhaite une bonne journée 🙂