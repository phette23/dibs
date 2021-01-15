<!DOCTYPE html>
<html lang="en">

  <head>
    <title>List of items currently available in the Caltech Digital Loan system</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.6/clipboard.min.js"></script>

  </head>
  
  <body>
    <div class="container-fluid">
      <h1 class="mx-auto text-center" style="width: 600px">
        Caltech DIBS
      </h1>
      <h2 class="mx-auto text-center" style="width: 600px">
        There are {{len(items)}} items available
      </h2>
      <div class="d-grid gap-3">

        <div class="mb-3">
          <table class="table">
            <thead class="thead-light">
              <tr>
                <th>Barcode</th>
                <th>Title</th>
                <th>Author</th>
                <th class="text-center">Available<br>copies</th>
                <th class="text-center">Loan<br>duration (hrs)</th>
                <th class="text-center">Copies<br>in use</th>
                <th></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
            %for item in items:
              <tr scope="row">
                <td>{{item.barcode}}</td>
                <td><a target="_blank" rel="noopener noreferrer"
                       href="https://caltech.tind.io/admin2/bibcirculation/get_item_details?ln=en&recid={{item.tind_id}}">{{item.title}}</a></td>
                <td>{{item.author}}</td>
                <td class="text-center">{{item.num_copies}}</td>
                <td class="text-center">{{item.duration}}</td>
                <td class="text-center">{{len([x for x in loans if x.item.barcode == item.barcode])}}</td>

                <td><button id="copyBtn" type="button" class="btn btn-secondary btn-sm"
                            onclick="confirmCopy(this);" data-clipboard-action="copy"
                            data-clipboard-text="http://localhost:8080/item/{{item.barcode}}">
                  <span id="button-text">Copy share link</span></button>
                </td>

                <td><form action="/remove" method="POST"
                      onSubmit="return confirm('Remove {{item.barcode}} (&#8220;{{item.title}}&#8221; by {{item.author}})? This will not delete the files from storage, but will remove the entry from the loan database.');">
                  <input type="hidden" name="barcode" value="{{item.barcode}}">
                  <input type="submit" name="Remove" value="Remove"
                         class="btn btn-danger btn-sm"/>
                </td>
                </form>
              </tr>
            %end
            </tbody>
          </table>
        </div>

        <div class="py-3 mx-auto" style="width: 150px">
          <a href="/add" class="btn btn-primary m-0">Add new item</a>
        </div>
      </div>
    </div>
  </body>

  <script>
   // This call to ClipboardJS must come after the page is defined.
   new ClipboardJS(".btn");

   // JavaScript to temporarily flash "Copied" when button is clicked.
   function confirmCopy(elem) {
     $(elem).text("Copied");
     setTimeout(() => $(elem).text("Copy share link"), 1000);
   }
  </script>

</html>
