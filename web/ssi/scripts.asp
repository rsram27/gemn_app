	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="<%= varApp %>lib/js/bootstrap.min.js"></script>



	<script type="text/javascript">
		$("[data-menu]").each(function () {
			var $this = $(this); 
			var $dataID = $(this).data("menu");
			var $dataSlider = $(this).data("slider");
			var $grupo = $(this).data("grupo");
			var $fechar = $(this).data("close");
			var $fecharCor = $(this).data("close-cor");
			var $atualizacoes = $(this).data("load");
			var $intervalo = $(this).data("interval");


			//console.log($this.hasClass("ativo"))
			$($dataID).addClass($dataSlider);
			if ($fechar) {
				$($dataID).append("<a class='sliderClose " + $fecharCor + "' data-close-slider><i class='fa fa-window-close'></i></a>");
			}
			if (typeof $atualizacoes != "undefined") {
				//console.log($atualizacoes);
				setInterval(function () {
					$.get($atualizacoes + "?atualizacoes=s", function (data, status) {
						//console.log(data)
						if (data > 0) {
							$this.addClass("novo");
							//console.log($atualizacoes);
							$($dataID).find(".conteudo").load($atualizacoes);
						}
					});

				}, $intervalo);
			}

			$("[data-grupo='" + $grupo + "']").addClass("true");

			$this.click(function () {
				if ($this.hasClass("ativo")) {
					//Se ja tiver ativo não precisa fazer nada na verdade...
					//$("[data-grupo='" + $grupo + "'],[data-hide]").removeClass("ativo true");
					//$("[data-grupo='" + $grupo + "']").not($this).hide("fast");
				
				} else {
					//Mostra o alerta referente a pessoa clicada 
					$("[data-grupo='" + $grupo + "'][id='" + $dataID.replace("#","") + "']").show("fast");
					//Marca que o alerta esta ativo "Aberto"
					$($dataID).addClass("ativo");
					$this.addClass("ativo").removeClass("inativo");
					$("[data-menu]").not($this).addClass("inativo").removeClass("ativo");
					$(".dataslider").not($dataID).removeClass("ativo");
					if (typeof $grupo != "undefined") {
						//console.log($grupo)
						$("[data-grupo='" + $grupo + "']").addClass("true");
					}

				}
			});


		});
		(function ($) {
			$.fn.sliderClose = function () {
				$(this).click(function () {
					$(".dataslider").hide("fast");
					$("[data-menu],.dataslider").removeClass("ativo true");
				});

			};
		})(jQuery);

		$("[data-close-slider]").sliderClose();

		$(".mq-return,.mq-btn-return").click(function (event) {
			event.preventDefault();
			history.back(1);
		})
		$("[data-filtro]").click(function (event) {
			event.preventDefault();
			var filtro = $(this).data("item");
			$(filtro).toggleClass("ativo");
		})
		var temcaminho = $("body").find(".mq-caminho").length;
		if (temcaminho == 1) {
			$("main").css("margin-top", "-30px");
		}
		$(window).load(function () {
			setTimeout(function(){
				$(".carregando").remove();
			})
		});
		$(".data-meta").each(function () {
			var meta = $(this).data("meta");
			$(this).find("span").css("width", meta + "%");
		})
		$(".mq-meta-itens .item").each(function () {
			var meta = $(this).data("meta");
			var label = $(this).data("label");
			$(this).find("span").css("height", meta + "%");
			$(this).append("<small style='bottom:" + meta + "%'>" + meta + "%</small>");
			$(this).append("<span style='bottom:-20px; font-size:12px;'>" + label + "</small>");
		})
		$(".labelCheck").click(function () {
			$(this).addClass("ativo").find("input").attr("checked", "checked");
			$(".labelCheck").not(this).removeClass("ativo").find("input").removeAttr("checked");

		})
	</script>





	<!-- 
	<script type="text/javascript">
		$("[data-menu]").each(function () {
			var $this = $(this); 
			var $dataID = $(this).data("menu");
			var $dataSlider = $(this).data("slider");
			var $grupo = $(this).data("grupo");
			var $fechar = $(this).data("close");
			var $fecharCor = $(this).data("close-cor");
			var $atualizacoes = $(this).data("load");
			var $intervalo = $(this).data("interval");


			//console.log($this.hasClass("ativo"))
			$($dataID).addClass($dataSlider);
			if ($fechar) {
				$($dataID).append("<a class='sliderClose " + $fecharCor + "' data-close-slider><i class='fa fa-window-close'></i></a>");
			}
			if (typeof $atualizacoes != "undefined") {
				console.log($atualizacoes);
				setInterval(function () {
					$.get($atualizacoes + "?atualizacoes=s", function (data, status) {
						//console.log(data)
						if (data > 0) {
							$this.addClass("novo");
							//console.log($atualizacoes);
							$($dataID).find(".conteudo").load($atualizacoes);
						}
					});

				}, $intervalo);
			}

			
			$("[data-grupo='" + $grupo + "']").addClass("true");
			
			$this.click(function () {
				
				if ($this.hasClass("ativo")) {
					//ao clicar em um item de lista CLIENTE
					//retira a visiblidade dos que ta visivel.
					$("[data-grupo='" + $grupo + "'],[data-hide]").removeClass("ativo true");
					$("[data-grupo='" + $grupo + "']").not($this).hide("fast");
				
				} else {
					//Deixa visivel o alerta que é do mesmo grupo do cliente 
					var $data_menu = $this.data("menu");
					$("[data-grupo='" + $grupo + "'][data_menu^='meta']").hide();
					$("[data-grupo='" + $grupo + "'][data_menu='" + $data_menu + "]").show("fast");
					$("[data-grupo='" + $grupo + "']").not("[data_menu^='meta']").show();
					$($dataID).addClass("ativo");
					$this.addClass("ativo").removeClass("inativo");
					$("[data-menu]").not($this).addClass("inativo").removeClass("ativo");
					$(".dataslider").not($dataID).removeClass("ativo");
					if (typeof $grupo != "undefined") {
						//$("[data-grupo='" + $grupo + "']").addClass("true");
					}

				}
			});


		});
		(function ($) {
			$.fn.sliderClose = function () {
				$(this).click(function () {
					$(".dataslider").hide("fast");
					$("[data-menu],.dataslider").removeClass("ativo true");
				});

			};
		})(jQuery);

		$("[data-close-slider]").sliderClose();

		$(".mq-return,.mq-btn-return").click(function (event) {
			event.preventDefault();
			history.back(1);
		})
		$("[data-filtro]").click(function (event) {
			event.preventDefault();
			var filtro = $(this).data("item");
			$(filtro).toggleClass("ativo");
		})
		var temcaminho = $("body").find(".mq-caminho").length;
		if (temcaminho == 1) {
			$("main").css("margin-top", "-30px");
		}
		$(window).load(function () {
			setTimeout(function(){
				$(".carregando").remove();
			})
		});
		$(".data-meta").each(function () {
			var meta = $(this).data("meta");
			$(this).find("span").css("width", meta + "%");
		})
		$(".mq-meta-itens .item").each(function () {
			var meta = $(this).data("meta");
			var label = $(this).data("label");
			$(this).find("span").css("height", meta + "%");
			$(this).append("<small style='bottom:" + meta + "%'>" + meta + "%</small>");
			$(this).append("<span style='bottom:-20px; font-size:12px;'>" + label + "</small>");
		})
		$(".labelCheck").click(function () {
			$(this).addClass("ativo").find("input").attr("checked", "checked");
			$(".labelCheck").not(this).removeClass("ativo").find("input").removeAttr("checked");
		})
	</script>
	-->