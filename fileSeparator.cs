using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Diagnostics;


class Program
{
    class RowData
    {
        public string CUSTOMER { get; set; }
        public string DEVICE_TYPE { get; set; }
        public string NUMBER { get; set; }
        public string SERVICE { get; set; }
    }

    static void Main()
    {
		Stopwatch stopwatch = Stopwatch.StartNew();

        string folder = @"C:\Temp";
        string outputFolder = @"C:\Temp";

        var items = Directory.EnumerateFiles(folder, "example_output_file_*.csv").ToList();
		var encoding = System.Text.Encoding.Default;

        List<RowData> uudetRivit = new List<RowData>();
        List<RowData> vanhatRivit = new List<RowData>();

        int i = 1;
        Console.WriteLine("----");

		foreach (var file in items)
		{
            var content = File.ReadAllLines(file, encoding);
            int intRivitTiedostossa = content.Length;
            int intRivitVanhat = 0;
            int intRivitUudet = 0;

            Console.WriteLine(string.Format("[{0} / {1}] [{2}]", i, items.Count, Path.GetFileName(file)));

            foreach (var row in content)
            {
                var columns = row.Split(';');
                var rivi = new RowData
                {
                    CUSTOMER = columns[0],
                    DEVICE_TYPE = columns[1],
                    NUMBER = columns[2],
                    SERVICE = columns[3]
                };

                if (row.Contains("Laptop"))
                {
					lock (uudetRivit)
					{
						uudetRivit.Add(rivi);
					}                    
                    intRivitUudet++;
                }
                else
                {
					lock (vanhatRivit)
					{
						vanhatRivit.Add(rivi);
					}
                    intRivitVanhat++;
                }
            }

            i++;
			Console.WriteLine(string.Format("Rivejä yht: {0}", intRivitTiedostossa));
			Console.WriteLine(string.Format("Laptop: {0}", intRivitUudet));
            Console.WriteLine(string.Format("Muita: {0}", intRivitVanhat));
            Console.WriteLine("----");
        }

		File.WriteAllLines(
			Path.Combine(outputFolder, "laptops_cs.csv"), 
			uudetRivit.Select(r => string.Join(";", r.CUSTOMER, r.DEVICE_TYPE, r.NUMBER, r.SERVICE)), 
			encoding
		);

		File.WriteAllLines(
			Path.Combine(outputFolder, "others_cs.csv"), 
			vanhatRivit.Select(r => string.Join(";", r.CUSTOMER, r.DEVICE_TYPE, r.NUMBER, r.SERVICE)), 
			encoding
		);
		
		stopwatch.Stop();
		
		Console.WriteLine(string.Format("Aikaa kului: {0} sekuntia", stopwatch.Elapsed.TotalSeconds));
    }
}
