#include<iostream>
#include<fstream>
#include<string>
#include<vector>
using namespace std;
int table[64][6] =
{
	0,0,0,0,0,0,//0  
	0,0,0,0,0,1,//1  
	0,0,0,0,1,0,//2 
	0,0,0,0,1,1,//3  
	0,0,0,1,0,0,//4 
	0,0,0,1,0,1,//5 
	0,0,0,1,1,0,//6 
	0,0,0,1,1,1,//7 
	0,0,1,0,0,0,//8 
	0,0,1,0,0,1,//9 
	0,0,1,0,1,0,//10  
	0,0,1,0,1,1,//11 
	0,0,1,1,0,0,//12 
	0,0,1,1,0,1,//13 
	0,0,1,1,1,0,//14 
	0,0,1,1,1,1,//15 
	0,1,0,0,0,0,//16 
	0,1,0,0,0,1,//17  
	0,1,0,0,1,0,//18 
	0,1,0,0,1,1,//19 
	0,1,0,1,0,0,//20 
	0,1,0,1,0,1,//21 
	0,1,0,1,1,0,//22 
	0,1,0,1,1,1,//23 
	0,1,1,0,0,0,//24 
	0,1,1,0,0,1,//25 
	0,1,1,0,1,0,//26 
	0,1,1,0,1,1,//27 
	0,1,1,1,0,0,//28 
	0,1,1,1,0,1,//29 
	0,1,1,1,1,0,//30 
	0,1,1,1,1,1,//31 

	1,0,0,0,0,0,//0  
	1,0,0,0,0,1,//1 
	1,0,0,0,1,0,//2 
	1,0,0,0,1,1,//3 
	1,0,0,1,0,0,//4  
	1,0,0,1,0,1,//5  
	1,0,0,1,1,0,//6 
	1,0,0,1,1,1,//7 
	1,0,1,0,0,0,//8 
	1,0,1,0,0,1,//9 
	1,0,1,0,1,0,//10
	1,0,1,0,1,1,//11
	1,0,1,1,0,0,//12 
	1,0,1,1,0,1,//13 
	1,0,1,1,1,0,//14 
	1,0,1,1,1,1,//15 
	1,1,0,0,0,0,//16 
	1,1,0,0,0,1,//17 
	1,1,0,0,1,0,//18 
	1,1,0,0,1,1,//19 
	1,1,0,1,0,0,//20 
	1,1,0,1,0,1,//21 
	1,1,0,1,1,0,//22
	1,1,0,1,1,1,//23 
	1,1,1,0,0,0,//24 
	1,1,1,0,0,1,//25  
	1,1,1,0,1,0,//26 
	1,1,1,0,1,1,//27
	1,1,1,1,0,0,//28  
	1,1,1,1,0,1,//29
	1,1,1,1,1,0,//30
	1,1,1,1,1,1//31  
}; 
string regis[32] =
{
	"$zero","$at","$v0","$v1",
	"$a0","$a1","$a2","$a3",
	"$t0","$t1","$t2","$t3",
	"$t4","$t5","$t6","$t7",
	"$s0","$s1","$s2","$s3",
	"$s4","$s5","$s6","$s7",
	"$t8","$t9","$k0","$k1",
	"$gp","$sp","$fp","$ra"
};
/*split a string*/
vector<string> Split(const string &s, const string &seperator) 
{
	vector<string> result;
	typedef string::size_type string_size;
	string_size i = 0;
	while (i != s.size()) 
	{
		//找到字符串中首个不等于分隔符的字母；
		int flag = 0;
		while (i != s.size() && flag == 0) 
		{
			flag = 1;
			for (string_size x = 0; x < seperator.size(); ++x)
				if (s[i] == seperator[x]) 
				{
					++i;
					flag = 0;
					break;
				}
		}

		//找到又一个分隔符，将两个分隔符之间的字符串取出；
		flag = 0;
		string_size j = i;
		while (j != s.size() && flag == 0) 
		{
			for (string_size x = 0; x < seperator.size(); ++x)
				if (s[j] == seperator[x]) 
				{
					flag = 1;
					break;
				}
			if (flag == 0)
				++j;
		}
		if (i != j) 
		{
			result.push_back(s.substr(i, j - i));
			i = j;
		}
	}
	return result;
}
int main()
{
	string origincode[100];
	vector<string> split0(6,"\0"),split1(6,"\0");
	int machinecode[100][32];
	int i=0,j;
	fstream f1;
	char sentence[100];
	f1.open("cpu.txt");
	while (!f1.eof())
	{
		f1.getline(sentence, 100);
		//cout << sentence << endl;
		origincode[i] = sentence;
		i++;
	}
	int sum = i;
	int totalline = 0;
	int judge(string str);
	int result;
	void expand(int *machine0, int *machine1, vector<string> split, int result);
	void convert(int *machine,vector<string>split, int result);
	for (i = 0; i < sum-1; i++)
	{
		split0 = Split(origincode[i]," ");
		if (split0.size() > 1)
		{
			split1.push_back("\0");
			split1 = Split(split0[1], ",");
			split1.insert(split1.begin(), split0[0]);
			split0.resize(split1.size());
			split0 = split1;
		}
		for (j=0;j<split0.size();j++)
			cout << split0[j] <<"#";
		cout << endl;
		result = judge(split0[0]);
		convert(machinecode[totalline], split0, result);
		totalline++;
	}
	return 0;
}
int judge(string str)
{
	if (str == "add" || str == "addu" || str == "sub" || str == "subu" || str == "and" || str == "or" || str == "xor" || str == "nor" 
		 || str == "sll" ||str == "srl" || str == "sra" || str == "slt" || str == "jr")
		return 0;//R type
	if (str == "blez" || str == "bltz"||str=="bgtz")
		return 1;// needs expansion
	if (str == "j" || str == "jal" || str == "jalr")
		return 2;//j type
	if (str == "nop")
		return 3;
	if (str == "addi" || str == "addiu" || str == "andi" || str == "slti" || str == "sltiu"||str =="beq" || str == "bne" || str == "lui")
		return 4;//I type
	if (str == "lw" || str == "sw")
		return 5;//saving
	return 6;//label
}
void convert(int *machine, vector<string>split, int result)
{
	int i,j,k;
	int shamt=0,off=0;
	int address=0, temp = 0,imm=0;
	vector<string> sub;
	/*R type*/
	if (result == 0)
	{
		/*assign 000000 as opcode*/
		for (i = 0; i <6; i++)
			*(machine + i) = 0;

		/*assign rs rt rd and shamt*/
		if (split[0] == "add" || split[0] == "addu" || split[0] == "sub" || split[0] == "subu" || split[0] == "and"
			|| split[0] == "or" || split[0] == "xor" || split[0] == "nor")
		{
			for (j = 21; j < 26; j++)
			{
				*(machine + j) = 0;//assign shamt
			}
			for (j = 1; j < 4; j++)
			{
				for (i = 0; i < 32; i++)
				{
					if (split[j] == regis[i])
					{
						if (j == 2)//$rs
						{
							for (k = 6; k < 11; k++)
								*(machine + k) = table[i][k - 5];
						}
						if (j == 3)//$rt
						{
							for (k = 11; k < 16; k++)
								*(machine + k) = table[i][k - 10];
						}
						if (j == 1)//$rd
						{
							for (k = 16; k < 21; k++)
								*(machine + k) = table[i][k - 15];
						}
					}
				}
			}
		}
		if (split[0] == "sll" || split[0] == "srl" || split[0] == "sra")
		{
			for (k = 6; k < 11; k++)
				*(machine + k) = 0;//assign $rs=0
			for (j = 1; j < 3; j++)
			{
				for (i = 0; i < 32; i++)
				{
					if (split[j] == regis[i])
					{
						
						if (j == 2)//$rt
						{
							for (k = 11; k < 16; k++)
								*(machine + k) = table[i][k - 10];
						}
						if (j == 1)//$rd
						{
							for (k = 16; k < 21; k++)
								*(machine + k) = table[i][k - 15];
						}
					}
				}
			}
			shamt = atoi(split[4].c_str());
			for (i = 0; i < 32; i++)
			{
				if (shamt == i)
				{
					for (j = 21; j < 26; j++)
						*(machine + j) = table[i][j - 20];
				}
			}
		}
		if (split[0] == "jr")
		{
			for (k = 11; k < 16; k++)
				*(machine + k) = 0;
			for (k = 16; k < 21; k++)
				*(machine + k) = 0;//assign rt,rd=0
			for (i = 0; i < 32; i++)
			{
				if (split[1] == regis[i])
				{
					for (k = 6; k < 11; k++)
						*(machine + k) = table[i][k - 5];//assign rs
				}
			}
		}

		/*assign funct code*/
		if (split[0] == "add")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[32][j - 26];
		}//32
		if (split[0] == "addu")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[33][j - 26];
		}
		if (split[0] == "and")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[36][j - 26];
		}//36
		if (split[0] == "sub")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[34][j - 26];
		}
		if (split[0] == "subu")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[35][j - 26];
		}
		if (split[0] == "or")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[37][j - 26];
		}
		if (split[0] == "xor")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[38][j - 26];
		}
		if (split[0] == "nor")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[39][j - 26];
		}
		if (split[0] == "sll")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[0][j - 26];
		}
		if (split[0] == "sra")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[3][j - 26];
		}
		if (split[0] == "slt")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[42][j - 26];
		}
		if (split[0] == "jr")
		{
			for (j = 26; j < 32; j++)
				*(machine + j) = table[8][j - 26];
		}
	}
	/*other branch type opcode rs offset*/
	if (result == 1)
	{
		/*assign opcode*/
		if (split[0] == "blez")
		{
			for (i = 0; i < 6; i++)
			{
				*(machine + i) = table[6][i];
			}
		}
		if (split[0] == "bgez")
		{
			for (i = 0; i < 6; i++)
			{
				*(machine + i) = table[1][i];
			}
		}
		if (split[0] == "bgtz")
		{
			for (i = 0; i < 6; i++)
			{
				*(machine + i) = table[7][i];
			}
		}
		/*assign rt 11:15*/
		if (split[0] == "blez"||split[0]=="bgtz")
		{
			for (i = 11; i < 16; i++)
			{
				*(machine + i) = 0;
			}
		}
		if (split[0] == "bgez")
		{
			for (i = 11; i < 16; i++)
			{
				*(machine + i) = table[1][i-10];
			}
		}
		/*assign rs 6:10*/
		for (i = 0; i < 32; i++)
		{
			if (split[1] == regis[i])
			{
				for (j = 6; j < 11; j++)
				{
					*(machine + j) = table[i][j - 5];
				}
			}
		}
		/*assign offset*/
		off = atoi(split[2].c_str());
		if (off < 0) off += 65536;
		for (i = 0; i < 16; i++)
		{
			*(machine + 31 - i) = off % 2;
			off /= 2;
		}
	}
	/*J type*/
	if (result == 2)
	{
		/*assign opcode*/
		if (split[0] == "j")
		{
			for (i = 0; i < 6; i++)
				*(machine + i) = table[2][i];
		}
		if (split[0] == "jal")
		{
			for (i = 0; i < 6; i++)
				*(machine + i) = table[3][i];
		}
		if (split[0] == "jalr ")
		{
			for (i = 0; i < 6; i++)
				*(machine + i) = table[2][i];
		}
		/*assign address*/
		address = atoi(split[1].c_str());
		temp = address;
		for (i = 0; i < 26; i++)
		{
			*(machine + 31 - i) = temp % 2;
			temp = temp / 2;
		}
	}
	/*nop*/
	if (result == 3)
	{
		for (i = 0; i < 32; i++)
			*(machine + i) = 0;
	}
	/*lui */
	if (split[0] == "lui")
	{
		for (i = 0; i < 6; i++)
		{
			*(machine + i) = table[15][i];
		}
		for (i = 6; i < 11; i++)
		{
			*(machine + i) = 0;
		}
		for (i = 0; i < 32; i++)
		{
			if (split[1] == regis[i])
			{
				for (j = 11; j < 16; j++)
				{
					*(machine + j) = table[i][j - 10];
				}
			}
		}
		imm = atoi(split[2].c_str());
		temp = imm;
		if (imm < 0)
			temp += 65536;
		for (i = 0; i < 16; i++)
		{
			*(machine + 31 - i) = temp % 2;
			temp /= 2;
		}
	}
	/*I type*/
	if (result == 4 && split[0]!="lui")
	{
		/*assign opcode*/
		{
			if (split[0] == "addi")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[8][i];
				}
			}
			if (split[0] == "addiu")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[9][i];
				}
			}
			if (split[0] == "andi")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[12][i];
				}
			}
			if (split[0] == "slti")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[10][i];
				}
			}
			if (split[0] == "sltiu")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[11][i];
				}
			}
			if (split[0] == "beq")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[4][i];
				}
			}
			if (split[0] == "bne")
			{
				for (i = 0; i < 6; i++)
				{
					*(machine + i) = table[5][i];
				}
			}
			
		}
		/*assign rs,rt*/
		for (j = 1; j < 3; j++)
		{
			for (i = 0; i < 32; i++)
			{
				if (split[j] == regis[i])
				{

					if (j == 1)
					{
						for (k = 6; k < 11; k++)
							*(machine + k) = table[i][k - 10];
					}
					if (j == 2)
					{
						for (k = 11; k < 16; k++)
							*(machine + k) = table[i][k - 15];
					}
				}
			}
		}
		/*assign immediate*/
		imm = atoi(split[3].c_str());
		temp = imm;
		if (imm < 0)
			temp += 65536;
		for (i = 0; i < 16; i++)
		{
			*(machine + 31 - i) = temp % 2;
			temp /= 2;
		}
	}
	/*lw and sw lw $rt,100($rs)*/
	if (result == 5)
	{
		/*assign opcode*/
		if (split[0] == "lw")
		{
			for (i = 0; i < 6; i++)
				*(machine + i) = table[35][i];
		}
		if (split[0] == "sw")
		{
			for (i = 0; i < 6; i++)
				*(machine + i) = table[43][i];
		}
		/*assign rt*/
		for (i = 0; i < 32; i++)
		{
			if (regis[i] == split[1])
			{
				for (j = 11; j < 16; j++)
					*(machine + j) = table[i][j - 10];
			}
		}
		/*assign rs and offset*/
		sub = Split(split[2], "(");
		string right = ")";
		int offset;
		for (i = 0; i < 32; i++)
		{
			if (sub[1] == regis[i] + right)
			{
				for (j = 6; j < 11; j++)
				{
					*(machine + j) = table[i][j - 5];
				}
			}
		}
		offset = atoi(sub[0].c_str());
		if (offset < 0)
			offset += 65536;
		for (i = 0; i < 16; i++)
		{
			*(machine + 31 - i) = offset % 2;
			offset /= 2;
		}
	}
}
/*may not be of use*/
void expand(int *machine0, int *machine1, vector<string> split, int result)
{
	//blez and bltz
	int i,j;
	int shamt;
	if (split[0] == "blez")
	/*blez rs shamt= slt $at,$rs,$zero  slt $rs $0 $1 0 0x2a
					 bne $at,$zero,shamt-1  5 $1,$0,shamt-1 */
	{
		/*0 rs 0 1 0 0x2a*/
		for (i = 0; i < 6; i++)
			*(machine0 + i) = table[0][i];//opcode=0
		for (i = 11; i < 16; i++)//rt
			*(machine0 + i) = table[0][i - 10];
		for (i = 16; i < 21; i++)//rd
			*(machine0 + i) = table[1][i - 15];
		for (i = 21; i < 26; i++)//0
			*(machine0 + i) = table[0][i - 20];
		for (i = 26; i < 32; i++)//0x2a
			*(machine0 + i) = table[33][i - 26];
		/*5 $1,$0,shamt-1*/
		for (i = 0; i < 6; i++)
			*(machine1 + i) = table[5][i];//opcode=5
		for (i = 6; i < 11; i++)
			*(machine1 + i) = table[1][i - 5];
		for (i = 11; i < 16; i++)
			*(machine1 + i) = table[0][i - 10];
		shamt = atoi(split[2].c_str());
		if(shamt<0)
			shamt--;
		if (shamt < 0)
			shamt += 65536;
		for (i = 0; i < 16; i++)
		{
			*(machine1 + 31 - i) = shamt % 2;
			shamt /= 2;
		}
		for (i = 0; i < 32; i++)
		{
			if (split[1] == regis[i])
			{
				for (j = 6; j < 11; j++)
					*(machine0 + j) = table[i][j - 5];
			}
		}
	}
}
