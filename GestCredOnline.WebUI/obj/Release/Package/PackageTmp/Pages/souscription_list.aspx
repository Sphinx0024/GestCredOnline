<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Contenu.master" AutoEventWireup="true" CodeBehind="souscription_list.aspx.cs" Inherits="Activ.BNI.CreditOnline.Pages.souscription_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <link type="text/css" href="/Assets/lib/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
    <link type="text/css" href="/Assets/lib/data-table/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link type="text/css" href="/Assets/lib/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentMain" runat="server">

    <div class="page-body">
        <div class="row">
            <div class="col-sm-12">

                <!-- Multi-column table start -->
                <div class="card">
                    <div class="card-header">
                        <h5>Mes demandes de prêts</h5>

                    </div>
                    <div class="card-block task-list">
                        <div class="table-responsive">
                            <div id="simpletable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-sm-12 col-md-6">
                                        <div class="dataTables_length" id="simpletable_length">
                                            <label>Show
                                                <select name="simpletable_length" aria-controls="simpletable" class="form-control input-sm">
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="100">100</option>
                                                </select>
                                                entries</label></div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-6">
                                        <div id="simpletable_filter" class="dataTables_filter">
                                            <label>Search:<input type="search" class="form-control input-sm" placeholder="" aria-controls="simpletable"></label></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12">
                                        <table id="simpletable" class="table dt-responsive task-list-table table-striped table-bordered nowrap dataTable no-footer dtr-inline" role="grid" aria-describedby="simpletable_info" style="width: 1172px;">
                                            <thead>
                                                <tr role="row">
                                                    <th class="sorting" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 24px;" aria-label="#: activate to sort column ascending">#</th>
                                                    <th class="sorting_asc" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 283px;" aria-label="Task list: activate to sort column descending" aria-sort="ascending">Task list</th>
                                                    <th class="sorting" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 237px;" aria-label="Last Commit: activate to sort column ascending">Last Commit</th>
                                                    <th class="sorting" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 125px;" aria-label="Status: activate to sort column ascending">Status</th>
                                                    <th class="sorting" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 173px;" aria-label="Assigned User: activate to sort column ascending">Assigned User</th>
                                                    <th class="sorting" tabindex="0" aria-controls="simpletable" rowspan="1" colspan="1" style="width: 73px;" aria-label="Action: activate to sort column ascending">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody class="task-page">




                                                <tr role="row" class="odd">
                                                    <td tabindex="0" class="">#12</td>
                                                    <td class="sorting_1">Add Proper Cursor In Sortable Page</td>
                                                    <td>
                                                        <input type="date" class="form-control">
                                                    </td>
                                                    <td>
                                                        <select name="select" class="form-control form-control-sm">
                                                            <option value="opt1">Open</option>
                                                            <option value="opt2">Resolved</option>
                                                            <option value="opt3">Invalid</option>
                                                            <option value="opt4">On hold</option>
                                                            <option value="opt5">Close</option>
                                                        </select>
                                                    </td>
                                                    <td class="">
                                                        <a>
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-1.jpg" alt=""></a>
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-2.jpg" alt=""></a>
                                                        <a href="#"><i class="icofont icofont-plus f-w-600"></i></a>
                                                    </td>
                                                    <td class="text-center">
                                                       <button onclick="window.location.href='/Pages/souscription_details.aspx'"  class="btn btn-primary" type="button"><i class="feather icon-eye"></i>Details
                                                            </button>
                                                        <button class="btn btn-success"><i class="feather icon-cast"></i>Soumettre
                                                            </button>
                                                        <button class="btn btn-danger"><i class="feather icon-x-circle"></i>Annuler
                                                            </button>
                                                    </td>
                                                </tr>
                                                <tr role="row" class="even">
                                                    <td tabindex="0" class="">#35</td>
                                                    <td class="sorting_1">Checkbox Design issue</td>
                                                    <td>
                                                        <input type="date" class="form-control">
                                                    </td>
                                                    <td>
                                                        <select name="select" class="form-control form-control-sm">
                                                            <option value="opt1">Open</option>
                                                            <option value="opt2">Resolved</option>
                                                            <option value="opt3">Invalid</option>
                                                            <option value="opt4">On hold</option>
                                                            <option value="opt5">Close</option>
                                                        </select>
                                                    </td>
                                                    <td class="">
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-1.jpg" alt=""></a>
                                                        <a href="#"><i class="icofont icofont-plus f-w-600"></i></a>
                                                    </td>
                                                    <td class="text-center">
                                                       <button class="btn btn-primary"><i class="feather icon-eye"></i>Details
                                                            </button>
                                                        <button class="btn btn-success"><i class="feather icon-cast"></i>Soumettre
                                                            </button>
                                                        <button class="btn btn-danger"><i class="feather icon-x-circle"></i>Annuler
                                                            </button>
                                                    </td>
                                                </tr>
                                                <tr role="row" class="odd">
                                                    <td tabindex="0" class="">#78</td>
                                                    <td class="sorting_1">Create UI design model</td>
                                                    <td>
                                                        <input type="date" class="form-control">
                                                    </td>
                                                    <td>
                                                        <select name="select" class="form-control form-control-sm">
                                                            <option value="opt1">Open</option>
                                                            <option value="opt2">Resolved</option>
                                                            <option value="opt3">Invalid</option>
                                                            <option value="opt4">On hold</option>
                                                            <option value="opt5">Close</option>
                                                        </select>
                                                    </td>
                                                    <td class="">
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-1.jpg" alt=""></a>
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-2.jpg" alt=""></a>
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-3.jpg" alt=""></a>
                                                        <a href="#"><i class="icofont icofont-plus f-w-600"></i></a>
                                                    </td>
                                                    <td class="text-center">
                                                       <button class="btn btn-primary"><i class="feather icon-eye"></i>Details
                                                            </button>
                                                        <button class="btn btn-success"><i class="feather icon-cast"></i>Soumettre
                                                            </button>
                                                        <button class="btn btn-danger"><i class="feather icon-x-circle"></i>Annuler
                                                            </button>
                                                    </td>
                                                </tr>
                                                <tr role="row" class="even">
                                                    <td tabindex="0" class="">#56</td>
                                                    <td class="sorting_1">Edit the draft for the icons</td>
                                                    <td>
                                                        <input type="date" class="form-control">
                                                    </td>
                                                    <td>
                                                        <select name="select" class="form-control form-control-sm">
                                                            <option value="opt1">Open</option>
                                                            <option value="opt2">Resolved</option>
                                                            <option value="opt3">Invalid</option>
                                                            <option value="opt4">On hold</option>
                                                            <option value="opt5">Close</option>
                                                        </select>
                                                    </td>
                                                    <td class="">
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-1.jpg" alt=""></a>
                                                        <a href="#">
                                                            <img class="img-fluid img-radius" src="../files/assets/images/avatar-2.jpg" alt=""></a>
                                                        <a href="#"><i class="icofont icofont-plus f-w-600"></i></a>
                                                    </td>
                                                    <td class="text-center">
                                                       <button class="btn btn-primary"><i class="feather icon-eye"></i>Details
                                                            </button>
                                                        <button class="btn btn-success"><i class="feather icon-cast"></i>Soumettre
                                                            </button>
                                                        <button class="btn btn-danger"><i class="feather icon-x-circle"></i>Annuler
                                                            </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-5">
                                        <div class="dataTables_info" id="simpletable_info" role="status" aria-live="polite">Showing 1 to 4 of 4 entries</div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-7">
                                        <div class="dataTables_paginate paging_simple_numbers" id="simpletable_paginate">
                                            <ul class="pagination">
                                                <li class="paginate_button page-item previous disabled" id="simpletable_previous"><a href="#" aria-controls="simpletable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                <li class="paginate_button page-item active"><a href="#" aria-controls="simpletable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                <li class="paginate_button page-item next disabled" id="simpletable_next"><a href="#" aria-controls="simpletable" data-dt-idx="2" tabindex="0" class="page-link">Next</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Zero config.table card end -->
                    <!-- Default ordering table card start -->
                    <!-- Default ordering table card end -->
                </div>
                <!-- Multi-column table end -->

            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFoot" runat="server">

    <script type="text/javascript" src="/Assets/datatables.net/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/Assets/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="/Assets/data-table/js/jszip.min.js"></script>
    <script type="text/javascript" src="/Assets/data-table/js/pdfmake.min.js"></script>
    <script type="text/javascript" src="/Assets/data-table/js/vfs_fonts.js"></script>
    <script type="text/javascript" src="/Assets/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="/Assets/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="/Assets/data-table/js/dataTables.bootstrap4.min.js"></script>

    <script type="text/javascript" src="/Assets/lib/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="/Assets/lib/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
    <script type="text/javascript" src="/Assets/lib/data-table/js/data-table-custom.js"></script>
</asp:Content>
