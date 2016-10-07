import Array._



object Test {
 
  var found:Int= -1
  var count:Int=0
  var key:Int= -1
  var array=ofDim[Int](count)

def main(args: Array[String]) {
    
println("Enter the number of elements")
count=io.StdIn.readLine.toInt
array=ofDim[Int](count)

println("Enter the elements in sorted order")
for(i<-0 to count-1)
{
  array(i)=io.StdIn.readLine.toInt  
  
}
println("Enter the element to be searched")
key=io.StdIn.readLine.toInt



println( "Value found at : (if value is -1, then not found) " + binarySearch(key,0,count-1))
}
  
  
  
  
def binarySearch(key:Int, start:Int, end:Int ) : Int = {
if(start==end){
  return found
}
var mid:Int=(start+end)/2

if(array(mid)==key){
  found=mid
}
else if(key<array(mid)){
  binarySearch(key,start,mid)
}else if(key>array(mid))
{
  binarySearch(key,mid+1,end)
  }
return found
}
}

