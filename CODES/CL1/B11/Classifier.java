import java.awt.BorderLayout;
import java.io.BufferedReader;
import java.io.FileReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.gui.treevisualizer.PlaceNode2;
import weka.gui.treevisualizer.TreeVisualizer;

public class Classifier { 

	private static final Logger logger = LoggerFactory.getLogger(Classifier.class);
	
    public static void main (String[] args) throws Exception 
    { 
            BufferedReader breader = null;
            
            
            
                breader = new BufferedReader (new FileReader("src/test.arff")); 
                Instances train = new Instances(breader); 
                train.setClassIndex(train.numAttributes()-1); 
                
                breader = new BufferedReader (new FileReader("src/test.arff")); 
                Instances test = new Instances(breader); 
                test.setClassIndex(test.numAttributes()-1); 
                
                breader.close();
                
                J48 tree= new J48(); 
                tree.setOptions(null); 
                tree.buildClassifier(train); 
               // Instances labeled = new Instances (test); 
                
                         
                Evaluation eval = new Evaluation(train);
    			eval.evaluateModel(tree, test);
    			System.out.println("Decision Tree\n");
    			logger.info(eval.toSummaryString("\nSummary\n======\n", false));
    			logger.info(eval.toClassDetailsString("\nClass Details\n======\n"));
    			logger.info(eval.toMatrixString("\nConfusion Matrix: false positives and false negatives\n======\n"));
    		//	System.out.println("Fmeasure"+eval.fMeasure(1));
    			
    		//	visualize(tree);
    			
            
    } 
    public static void visualize(J48 tree) throws Exception{
		// display classifier
	     final javax.swing.JFrame jf = new javax.swing.JFrame("Tree Visualizer: J48");
	     jf.setSize(500,400);
	     jf.getContentPane().setLayout(new BorderLayout());
	     TreeVisualizer tv = new TreeVisualizer(null,(tree).graph(),new PlaceNode2());
	     jf.getContentPane().add(tv, BorderLayout.CENTER);
	     jf.addWindowListener(new java.awt.event.WindowAdapter() {
	       public void windowClosing(java.awt.event.WindowEvent e) {
	         jf.dispose();
	       }
	     });
	 
	     jf.setVisible(true);
	     tv.fitToScreen();
	}
} 

/*
 Decision Tree

Oct 05, 2015 11:26:29 PM Classifier main
INFO: 
Summary
======

Correctly Classified Instances         627               85.4223 %
Incorrectly Classified Instances       107               14.5777 %
Kappa statistic                          0     
Mean absolute error                      0.0876
Root mean squared error                  0.2093
Relative absolute error                 98.2695 %
Root relative squared error             99.9929 %
Total Number of Instances              734     

Oct 05, 2015 11:26:29 PM Classifier main
INFO: 
Class Details
======

               TP Rate   FP Rate   Precision   Recall  F-Measure   ROC Area  Class
                 0         0          0         0         0          0.5      audio
                 1         1          0.854     1         0.921      0.5      pdf
                 0         0          0         0         0          0.5      excerpt
                 0         0          0         0         0          0.5      pamphlet
                 0         0          0         0         0          0.5      unknown
                 0         0          0         0         0          0.5      video
Weighted Avg.    0.854     0.854      0.73      0.854     0.787      0.5  

Oct 05, 2015 11:26:29 PM Classifier main
INFO: 
Confusion Matrix: false positives and false negatives
======

   a   b   c   d   e   f   <-- classified as
   0   3   0   0   0   0 |   a = audio
   0 627   0   0   0   0 |   b = pdf
   0   3   0   0   0   0 |   c = excerpt
   0  37   0   0   0   0 |   d = pamphlet
   0  50   0   0   0   0 |   e = unknown
   0  14   0   0   0   0 |   f = video
*/

